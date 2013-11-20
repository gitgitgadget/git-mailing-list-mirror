From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Bizarre git merge behaviour
Date: Wed, 20 Nov 2013 16:34:09 +0100
Message-ID: <528CD671.7090702@gmail.com>
References: <l6hbgg$oej$1@ger.gmane.org> <528C62BE.7060803@viscovery.net> <20131120120326.GD26413@debian.cengia.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthew Cengia <mattcen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 16:34:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj9nH-0000ge-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 16:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab3KTPeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Nov 2013 10:34:15 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:48084 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3KTPeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 10:34:14 -0500
Received: by mail-ee0-f54.google.com with SMTP id e51so3846822eek.13
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=a8vuFRau+efUYr1fWWAqROjxMSSz8V/7aJBNmbQl9p4=;
        b=JPf8U5vvy0lyDIephSDNE1/Sg31SNAosoDFn3yIKmK+C+AnS/2i6MLLk2f1zuEkk6i
         Xe67fBBM47jJ0KhMopdAhIsOhLWXOfIceQ9+tkVeuxbbuIfYfpUl8xUfOiZhAlr0GKwI
         INK8rXE4F26SgZFf9fwKDgUg01bxIy/yaKPZog3jw52Rc/TvGTIi56ZYKT8QVRaWk5ik
         56MKuYLuDvb5S/S7szPfb53X/PPw5IM7Z9fEylAAjuZK73w7F1LpbCdNgTIwtjEtZeMw
         M5ds2KkJpQkyTXnq7MnjhNWiHZnXvrM6DT8U2Qa3sOySp+Q6j3TgmeAfoR5gvxqFvgi6
         XqUQ==
X-Received: by 10.15.54.199 with SMTP id t47mr1733846eew.46.1384961653261;
        Wed, 20 Nov 2013 07:34:13 -0800 (PST)
Received: from [158.75.2.83] ([158.75.2.83])
        by mx.google.com with ESMTPSA id v45sm11249769eef.11.2013.11.20.07.34.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 07:34:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20131120120326.GD26413@debian.cengia.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238081>

W dniu 2013-11-20 13:03, Matthew Cengia pisze:
> On 2013-11-20 08:20, Johannes Sixt wrote:
> [...]
>> Not really. It's impossible to tell what's wrong if you
>
> Hi Hannes,
>
> Thanks for your response, and sorry for providing insufficient
> information; this is a company Git repo (it's also about 200MB), so I=
've
> got be careful what I post, but I can certainly give more than I've
> shown already.

I think there is some anonymizing tool for git, which replaces data
(blobs contents and file names) with artificial names, while preserving
history.  It was intended to help debug repos with proprietary data...
but unfortunately I have not bookmarked it (or lost bookmark).

[...]
> I'm truly stumped. It's also worth noting that I've gone through and
> manually resolved this merge one file at a time, and I'm about 90% su=
re
> I ended up with the correct result, but it'd be nice to have had the
> merge do the right thing in the first place, and I obviously want to
> avoid having to do this again in a few months' time.

Well, there is git-rerere (reuse recorded resolutions) which records=20
file-level (textual) merge resolutions and tries to reapply if=20
appropriate when merging.

Perhaps git-imerge tool would be of help in complicated merges?

--=20
Jakub Nar=C4=99bski
