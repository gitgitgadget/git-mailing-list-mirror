From: John Szakmeister <john@szakmeister.net>
Subject: Re: git repository size / compression
Date: Fri, 9 Sep 2011 12:05:03 -0400
Message-ID: <CAEBDL5U5-1nBGbWtb6+CfBrESoy8+p0Qqw1t1n_5EKFmpq9NhA@mail.gmail.com>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
	<1315556595.2019.11.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: neubyr <neubyr@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23Zp-0006pS-Om
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900Ab1IIQFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 12:05:05 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58830 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1IIQFE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 12:05:04 -0400
Received: by vxi9 with SMTP id 9so1207552vxi.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oJMMdTGRVZiZZdblU9peT5u56GCpvzFea9x8rFyBVck=;
        b=ELUhKyIN5tJG6O/huXwHUt1bWnXU5LuTOG+OfSKb0RovA+WxKXVojlGX7AsHBdM8gm
         Dpx+ptOb/FXwxuXa0y8yfXGOsr5269ZoQRZS6YsHotI65GcskF+MiJwiryO9aEESBChI
         qAfjPTUem1TPGd66py049tlGrmJsbd5O/dtfQ=
Received: by 10.52.112.163 with SMTP id ir3mr599911vdb.124.1315584303941; Fri,
 09 Sep 2011 09:05:03 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Fri, 9 Sep 2011 09:05:03 -0700 (PDT)
In-Reply-To: <1315556595.2019.11.camel@bee.lab.cmartin.tk>
X-Google-Sender-Auth: UlEt21zRx7LrhhZ5PC6PeTrXMos
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181089>

On Fri, Sep 9, 2011 at 4:23 AM, Carlos Mart=C3=ADn Nieto <cmn@elego.de>=
 wrote:
[snip]
>> Subversion repo/server:
>> {{{
>> $ du -h -d 1
>> =C2=A012K =C2=A0 =C2=A0./conf
>> 1.2M =C2=A0 =C2=A0./db
>> =C2=A036K =C2=A0 =C2=A0./hooks
>> 8.0K =C2=A0 =C2=A0./locks
>> 1.2M =C2=A0 =C2=A0.
>> }}}
>
> I don't know how the repository is stored in Subversion, but it may a=
lso
> be compressed. You may be able to reduced your git repository size by
> (re)generating packs with 'git repack' and doing some cleanups with '=
git
> gc', but the repository size is not often a concern.

It is stored compressed in Subversion, and it also generates deltas
against previous versions.  IIRC, the delta algorithm in an xdelta
based one, and then the data is run through compression.  Subversion
will at times choose to self-compress the file, instead of doing a
delta and compressing.  IIRC, there is some heuristics in there for
determining when to do that, but I forget the exact method.

HTH!

-John
