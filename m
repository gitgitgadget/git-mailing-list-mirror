From: demerphq <demerphq@gmail.com>
Subject: Re: shared permissions on COMMIT_EDITMSG
Date: Thu, 28 Jan 2010 18:57:11 +0100
Message-ID: <9b18b3111001280957q3806667ci88b9ec58b94d81cc@mail.gmail.com>
References: <4B61569A.1010808@gmail.com> <20100128111425.GA29577@Knoppix>
	 <4B61C371.4050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 18:59:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaYcM-0001Q0-06
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 18:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab0A1R5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 12:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084Ab0A1R5P
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 12:57:15 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:59357 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0A1R5P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 12:57:15 -0500
Received: by bwz27 with SMTP id 27so743041bwz.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o5m9QnVmKEdaEQusxf6F/qBN043c/nE1XuJJnC3EOSY=;
        b=CaOLlfwiX6hupGTX2BpmAF2kYnrUgMdz1UIM1HirZWbOfjX7PNVElUNNeuplYNIxJx
         8wJj7v9Vn81MBfymSayHkomQgikrL6g7X1RLIrkZ/r8eR2I4iIC5dQGM0J0OOiFKTYYf
         gMu5gOSwDmgSkcrsgzwUm8LE0jbzCtEH/g8JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vj5Q+Zr/gFKA81FGVKoX5MviNrusVFHFo7RJUO7Ccrm+geeyuj2hN0pLx16cOXHVpo
         zKyt727EkLUXNTCKrfmfrbw1bNjdiN/OX4UPINzu3Q5O1GqeiVo/O5ZqGrG1kNrPrcCI
         pksX9/BmUY9/Yw3SgA7BttexPcXb8Gd7EEBNs=
Received: by 10.239.187.209 with SMTP id m17mr1310015hbh.148.1264701432399; 
	Thu, 28 Jan 2010 09:57:12 -0800 (PST)
In-Reply-To: <4B61C371.4050903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138262>

2010/1/28 William Pursell <bill.pursell@gmail.com>:
> Ilari Liusvaara wrote:
>> On Wed, Jan 27, 2010 at 11:19:22PM -1000, William Pursell wrote:
>>> With git-init --shared=3D0660 and a umask of 022,
>>> the first commit to the repository creates
>>> the file COMMIT_EDITMSG with mode 0644
>>> instead of 0660. =A0I believe this is incorrect
>>> behavior. =A0Simple fix:
>>
>> COMMIT_EDITMSG is related to committing, committing needs
>> working copy, and shared working copies don't work all too
>> well (and Git can't do anything about that because all kinds
>> of stuff edits the files there, not just Git).
>>
>> Shared repository settings are meant to override umasks
>> for files in actual repository itself.
>
> For simple work flows (eg recording linear history
> of config files), sharing a working directory
> works okay except for COMMIT_EDITMSG. =A0Since
> COMMIT_EDITMSG is in the git repository and only
> written by git, it makes sense for core.sharedrepository
> to be honored.

I agree.  And personally ive used shared working directories quite a
bit without issue. Thanks be to git --interactive.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
