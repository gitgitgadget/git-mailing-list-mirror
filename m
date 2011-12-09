From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/9] revert: simplify getting commit subject in format_todo()
Date: Sat, 10 Dec 2011 02:28:19 +0530
Message-ID: <CALkWK0nCqWj0Hx0EGoONMAs-85wvwjMnEAaBW06AMT6Oz373vA@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-5-git-send-email-artagnon@gmail.com> <20111209194727.GF20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7Wo-0005nR-Ps
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1LIU6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:58:41 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65242 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab1LIU6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:58:41 -0500
Received: by qadc12 with SMTP id c12so896319qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y/2gSKfZMnS97b/evFm2pHVBCQvW//sWdwOAd+Kpve0=;
        b=nihX6vm61+j4Ho8P/Xt7Q5kgeFQjR1kAAqKKcbgA+2vNLJ1zNtjDLDNOKTjFXeqRvM
         XTaK7ePc23RBJsPJbJ6IIBkQTx6iRJrzh/p4gxf80ZIcLrt26k+HN9JTBj4v2QbsWob1
         jq6i2Ji8kLOvl+pawpZ0CmbatpXSLtcbqxtZc=
Received: by 10.224.180.131 with SMTP id bu3mr8702448qab.5.1323464320261; Fri,
 09 Dec 2011 12:58:40 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Fri, 9 Dec 2011 12:58:19 -0800 (PST)
In-Reply-To: <20111209194727.GF20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186694>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> [...]
> Can cur->item->buffer be NULL?

As Junio correctly points out in $gmane/186365, no.  To quote him:

   parse_insn_line() uses lookup_commit_reference() which
   calls parse_object() on the object name (and if it is a tag, deref_tag()
   will parse the tagged object until we see something that is not a tag), so
   we know cur->item is parsed before we see it

>> Also, remove the unnecessary check on cur->item: the previous patch
>> makes sure that instruction sheets with missing commit subjects are
>> parsable.
>
> But now I am confused
> [...]

This part of the commit message is simply awful.  Replaced with:

   Also remove the unnecessary check on cur->item->buffer:
   the lookup_commit_reference() call in parse_insn_line() has already
   made sure of this.

-- Ram
