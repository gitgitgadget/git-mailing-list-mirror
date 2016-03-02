From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 16:28:59 +0700
Message-ID: <CACsJy8D69ieHSKTFC=0hsz1Ss+bgajxXmcyf4Ma7mrjWrp_NXA@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk> <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
 <20160302075437.GA8024@x> <xmqq4mcp5lij.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:29:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab369-00026o-3M
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbcCBJ3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:29:32 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33474 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbcCBJ3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:29:31 -0500
Received: by mail-lb0-f171.google.com with SMTP id k15so3645861lbg.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NQG9XcAfUwHN7OIeZHSQYY+AlyiUshRRHkOsxJU81Bc=;
        b=cfJFMin/aUT/3gmhIV0Szeiclv7SnAKE+PBMhzfOvee1ccTnqHuNhR6wbBIMCxZL7H
         YqI//SU5CkyfdriRGtul2aRp7DrwMalyC3cH2SGSol1fqEUfC/ndyq31GiP37KXQ1F4B
         d6D9ixJMmYs633QMAe7JRgTmyV7lJ8UdxLCuo0ik52afGRW96IR6e+ugnNGQl7alkFnR
         tF+hC+K6YHYpzFkWZvrItpcm+2NYNTAz6ODqFxtNMWJEy8LdUJIDKk4kSQMRjjcYebcB
         zRaw2QfjeX5eEPz+Ax29h9vulo28qPD2MbACvLI+g7t89cgNcvJc5+wJsIPky4wy96q2
         mccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NQG9XcAfUwHN7OIeZHSQYY+AlyiUshRRHkOsxJU81Bc=;
        b=CiukyqyqgqG/KNUymIfAlIy/GszVPWquU/VG87e9q86UTBB91eas56/qCFhr9sbbbK
         dcOR5dEqZW4hgMijHVfU/ZLoqNtzI1HYkIolPU4nqvGIBaBHCuUFTvg87i1aX8tQ6h1b
         2gOeKv4H9HdvXYIXjA3pEMafeu67+JqeqVehODNTYlJKaBX7WTGjENANNKnvq2k9q8H+
         Rm1ahDokHQVTtArP+opuyacNUwAO/0okU+CMrbJcoBEOAufI5Nh2a252LUgXy3lKGkCK
         4HzxOsLtzMvJgKj5hG6RXSwPSFN2lJCoe6jvcuya4HNk8KtjnFACGHs0Hx3ITiGhDrfT
         n66g==
X-Gm-Message-State: AD7BkJIVuymZliYXWTo6V/MzcdpirfKNDHLaLcU0aWxEb7+gPY4ZVo+QLm8I64Im8Dg9L65C62FjutOZoWd8VA==
X-Received: by 10.112.150.133 with SMTP id ui5mr9528786lbb.12.1456910969190;
 Wed, 02 Mar 2016 01:29:29 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Wed, 2 Mar 2016 01:28:59 -0800 (PST)
In-Reply-To: <xmqq4mcp5lij.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288118>

On Wed, Mar 2, 2016 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
>
>> I don't think it's worth the trouble and ambiguity to send abbreviated
>> object names over the wire.
>
> Yup.  My unscientific experiment was to show that the list would be
> far smaller than the actual transfer and between full binary and
> full textual object name representations there would not be much
> meaningful difference--you seem to have a better design sense to
> grasp that point ;-)

It may matter, depending on your user target. In order to progress a
fetch/pull, I need to get at least one object before my connection
goes down. Picking a random blob in the "large file" range in
linux-2.6, fs/nls/nls_cp950.c, 500kb. Let's assume the worst case that
the blob is transferred gzipped, not deltified, that's about 100k.
Assume again I'm a lazy linux lurker who only fetches after every
release, the rev-list output between v4.2 and v4.3 is 6M. Even if we
transfer this list over http with compression, the list is 2.9M, way
bigger than one blob transfer. Which raises the bar to my successful
fetch.
-- 
Duy
