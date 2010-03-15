From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: merging unmanaged working tree
Date: Mon, 15 Mar 2010 14:22:16 -0500
Message-ID: <32541b131003151222r32244cf4o6182545e3a1eb1aa@mail.gmail.com>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl> <46a29168.6d880e7c.4b9e296c.483a1@o2.pl> 
	<87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>
X-From: git-owner@vger.kernel.org Mon Mar 15 20:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrFsA-0007fj-QS
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 20:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965755Ab0COTWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 15:22:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53022 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965750Ab0COTWh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 15:22:37 -0400
Received: by gyg8 with SMTP id 8so1589532gyg.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=trO/nJZrvOPujgUfpwK6dZGQrLTiw809tEuC6nVrNz8=;
        b=v5tohYriwN85IwmeZnQ9Fy0r9O8WRP//bAP3cqtZMwdOqedY/kcFk33ZpYoSxHHuT5
         x9P2RkULz88vWn8tlvkujWrZkDhx/1WIH2p5NWZ9c8US4Fr1DiqJmnBl7AfdpIYmnrsA
         V9n/CBfmRQogWXEddoI9eeCnRFhYmrw06wnN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=owj9pnCHGydxZ1sR0Cji/KRDRuBo8S16MM/5Y9j/75i5WRQxNTFRXoI8bajja/7XAG
         iUdXXHfzdueuBYPXefUlY65lNnuCErS7eCdeWhDgyg35+I7eQ8+hTOa2RFcpL7iO7+X7
         ayFCLQL0hsJ4gsncLKbS2rDOnBx9Uan9uw3wM=
Received: by 10.150.237.18 with SMTP id k18mr3602340ybh.247.1268680956136; 
	Mon, 15 Mar 2010 12:22:36 -0700 (PDT)
In-Reply-To: <87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142246>

2010/3/15 =C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl>:
> 1. There is a repository (non-bare one) with all changes
> =C2=A0 commited. Commit A.
>
> 2. I take some files put them on my pendrive. I take a note that they=
 come
> =C2=A0 from commit A. I don't clone the repository.
>
> 3. I make changes here (in the repository) and commit them (commits B=
,
> =C2=A0 C, D) and there (on my pendrive).
>
> 4. I want to merge things with something like this

You have a few options that I can think of.

a) Look at 'git clone --depth' so you can clone only the most recent
version of the files, not the *entire* repo.  This lets you do commits
on any computer you want with the pen drive plugged in, but saves
space.

b) Keep your .git directory on your main PC's disk, and the working
tree on your pen drive.  Look at the GIT_DIR environment variable in
'man git'.  Then when you bring the pen drive back to your PC, you
have the full repo available.  (If you use 'git clone --reference'
when making the new repo, the extra .git directory should take only
minimal space.)

c) Make a clone of your repo on the PC, then rsync the non-git parts
of that clone's work tree to and from your pen drive.  (This option is
the most error-prone since you have to make sure you never rsync in
the wrong direction at the wrong time.  But it's maybe the easiest to
understand.)

Hope this helps.

Have fun,

Avery
