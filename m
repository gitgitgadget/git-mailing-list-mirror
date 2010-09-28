From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Tue, 28 Sep 2010 21:56:45 +0800
Message-ID: <AANLkTinrOxDvzm2-zG+huNp=00+o4XqYwnsfhjOFEEoH@mail.gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
	<7v7hi6us35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, David Ripton <dripton@ripton.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 15:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0aft-00030k-M8
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab0I1N4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 09:56:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35454 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0I1N4r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 09:56:47 -0400
Received: by iwn5 with SMTP id 5so6003688iwn.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CtnE5/c7vxBlB4q4SyY1CaoQbddkmfoCKVUn6kQnphk=;
        b=YHIhrSBIxIh4uTzgXJvTAySxd8RWZITw+M3cJHAtAmt+yeU578wQN6njyjIt7Q+qyb
         1nDQr0MIPcd1FDHkzcWULKPo4vuI5gkEicYQA4pk49Iu89+rId+P7RHwwFewREnXHOgo
         i7WoJP/V4LzQuwYNn8ORAnbxCvPiQCqTl+Kog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PAmooN+WmDur/cWscIsidp06bwMKuJ4oZMuH80Lay77c1wDTjKpUTMYpBWEQiU+aZu
         N+9dS/an3mG3WDA5CfHLcHFw32HcZyMwVuDBTr+DpCmBF1lLvpzZfOFERnFUUMI2Tx10
         DRmrnFNL4FUr6mh2eD7uWP6K20cY74RNY/2vM=
Received: by 10.231.11.69 with SMTP id s5mr11030253ibs.38.1285682206016; Tue,
 28 Sep 2010 06:56:46 -0700 (PDT)
Received: by 10.231.13.197 with HTTP; Tue, 28 Sep 2010 06:56:45 -0700 (PDT)
In-Reply-To: <7v7hi6us35.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157424>

2010/9/28 Junio C Hamano <gitster@pobox.com>:
> Just a couple of quick notes.
>
> =A0- I had to eject Bo's "log -L range path" series in order to push =
this
> =A0 out on 'pu' as the range stuff adds new callsites to the old path=
spec
> =A0 API.
>
> =A0 This is tentative and does not mean Bo's series is getting reject=
ed;
> =A0 I'd want to get its command line parsing around the pathnames fix=
ed
> =A0 anyway but I suspect the affected codepath would overlap between =
the
> =A0 two series. =A0Help is appreciated.

Ah, it is not very astonished to see this series put into 'pu' since I
am not active these days. :)

Hmm, let me make a summary about the requirement for the pathname
command line options:
1. The syntax now 'git log <rev> -L l:m path1 -L l:m path2' got clash
with current git command line style 'git subcommand dash-option <rev>
path'. Since we support multiple paths with multiple ranges, I think
the best way to comply with git command line style is to change it to
'git log -L l:m path1 -L l:m path2 <rev>'.

2. The way I parse the command line should make a little change, that
in '-L' in callback to parse both range and path arguments.

That's it?

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
