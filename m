From: Kasra Khosoussi <kasra.mail@gmail.com>
Subject: corrupted Git repository
Date: Tue, 21 Jun 2011 11:28:50 +0430
Message-ID: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 08:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYuvI-0007tk-6O
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 08:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab1FUG6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 02:58:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56934 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1FUG6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 02:58:51 -0400
Received: by pvg12 with SMTP id 12so1275714pvg.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=oteq2x4HZDGFMfcccrcjlSPLY77zOwrnc60ZQ+U/MUM=;
        b=Hu5CyST4EW8y7MASEu7gXMWV7rHo0qA4fcnVGl6KMIa6tSYF1sdQTFa1eyzfo3bY62
         nAzk62pEPXtOSBuhw8LPX1MZaMyyxH+1M8DV5jiCONoaUfX4HSpwVFRFqb0+g5aTMzke
         mgZwWDCDogieS4oinGq78mRThtRIvEkF/Qrxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WNIq++Y1vsAg9+T7WgAoS3Ac/G1eWmUOzyQZOSJSXHnRMgcg2BEs1jnZbFWJsBFTk9
         8pT61nx6L/cHm/enMgQJsjcuNJJpZlA6t0hsbwaOvz5Jw8RzMyE8fjWLzI9iMpr5pmJv
         CjF6upjjgphk10BJjMF4KICtuL0JZwJl4+A9M=
Received: by 10.68.9.231 with SMTP id d7mr2852318pbb.111.1308639530547; Mon,
 20 Jun 2011 23:58:50 -0700 (PDT)
Received: by 10.68.55.132 with HTTP; Mon, 20 Jun 2011 23:58:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176129>

Hi all,

My thesis repository is corrupted and I don't have any recent backup
(my files are OK, but the history is lost). I've seen the recovery
examples in the manual, but I believe my case is somehow different.
The repository is linear.

1- At the beginning, git status/log/fsck -full said:

> fatal: object 0a83757505387aacc2fd36b3c996729e6bf9d6e5 is corrupted

and there was an empty file in .git/objects/01/8375... .

2- If I move the corrupted object, git fsck --ful would return this:

> error: HEAD: invalid sha1 pointer 0a83757505387aacc2fd36b3c996729e6bf9d6e5
> error: refs/heads/master does not point to a valid object!
> dangling tree 06f388dc60cfb014b5e1f70ecdaa568efe6bd0fa
> dangling tree d86f8c75e836e13b6e0336361641223f48fde722

3- I guess I have to edit refs/heads/master and replace the corrupted
sha1 with another hash, but I'm not sure how I can find the proper
commit (e.g.,maybe by using find -mtime?).

Thanks in advance,

-Kasra
