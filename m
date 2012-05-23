From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 13:03:02 -0400
Message-ID: <CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <4FBC0019.6030702@in.waw.pl> <7v4nr72bim.fsf@alter.siamese.dyndns.org> <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?ISO-8859-1?Q?Ville_Skytt=E4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 19:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEy7-0007uu-TZ
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 19:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2EWRDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 13:03:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62593 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab2EWRDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 13:03:22 -0400
Received: by weyu7 with SMTP id u7so4781950wey.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 10:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=dkim-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=XjUVJ4tDwSsCGUcGDgRlLz6Yaih7JSiWpE2LrvVSdx8=;
        b=dsxX3Pd3QHqNg306VMQmC7Go1+3c3poeYMq/7Tg691bg1S1tMr4zONBjJvcw7p0wvB
         +OdDxfBIJo8dDQ/I7ZsJW5+KlWbqluWmf5l+4HkTDF3G24fdj+527046Sy/Owmrgsgfm
         /oVh0aoNo1W/GiAT16TkEXIpbGUhP/M2KRzgFb9I+k1LyMU5NNv9oegRJYzE6wvkq2PC
         WqXnDjw9RZEU9xhqAhLChrt+3dupnTz+pPAdCfs1FMhm8PjfRnNonTM4Gv7VDoWHbzEp
         7pl0EZpA9tFxHaFzXUGhrQzym5vaH02/McDJSs4mtLZ4LHm4X8YGJvz0hnqO9z7gad9B
         ao1w==
Received: by 10.180.107.99 with SMTP id hb3mr47605060wib.0.1337792599784;
        Wed, 23 May 2012 10:03:19 -0700 (PDT)
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com [209.85.212.178])
        by mx.google.com with ESMTPS id e20sm36444595wiv.7.2012.05.23.10.03.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 10:03:18 -0700 (PDT)
Received: by wibhn6 with SMTP id hn6so4972273wib.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tedpavlic.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XjUVJ4tDwSsCGUcGDgRlLz6Yaih7JSiWpE2LrvVSdx8=;
        b=TdGoHuSoJ+3qdW/mU9Cb/rWDQByljK1IklmDV0Wv35Rx2a+2E/2qEiKgzKrdTjM2MG
         skcAOtm5tT6HB7ymyszEGZ2dYxlgjBUMpWgW9ue/L6g89Ykqt53bx5RwbIWd3Qsri5Gh
         gAY4wmOaeCf6MeCF7pr0ApH+Bx+7iPGB79/sQ=
Received: by 10.180.93.38 with SMTP id cr6mr47736950wib.16.1337792597372; Wed,
 23 May 2012 10:03:17 -0700 (PDT)
Received: by 10.216.131.211 with HTTP; Wed, 23 May 2012 10:03:02 -0700 (PDT)
In-Reply-To: <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQmpljDRZebHC+IbLrplv4CqL8GT93SGPK79qBkKgvEIUfdhz0QuehjBKI9bmsCUr3PfKlv/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198312>

>> I am not sure if that is worth it. =A0These two share/duplicate some=
 shell
>> functions and we may end up refactoring them (a way to do so may be =
to
>> dot-source git-prompt from git-completion and drop duplicated defini=
tions
>> from the latter), for example.
>
> And how do you propose to update the install documentation?
>
> 1) Copy the file (e.g. ~/.git-completion.sh)
> 2) Copy the other file (.e.g ~/.git-prompt.sh)
> 3) Edit the original file (~/.git-completion.sh), modify the 'source'
> command to use the other file (~/.git-prompt.sh)

The third step doesn't seem necessary if .git-completion sources
git-prompt when it's available (and otherwise ignores it gracefully).
Then anyone who cares about the prompt just makes sure that git-prompt
is available.

--=20
Ted Pavlic <ted@tedpavlic.com>
