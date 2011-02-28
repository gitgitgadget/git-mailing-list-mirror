From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: False alarms from git-fsck(1) about missing commits/trees pushed
 after the run started
Date: Mon, 28 Feb 2011 13:38:56 +0100
Message-ID: <AANLkTimrgepw4r=z5na-d74XY67QuRRgFepWZh87xrCq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 13:41:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2Pm-0002mB-Fb
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 13:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829Ab1B1MlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 07:41:21 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51044 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1B1MlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 07:41:21 -0500
Received: by fxm17 with SMTP id 17so3673412fxm.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=K1MKBHL44RGzeYUskIm0H9K4xp8wdzFDmYHsEiH/Efw=;
        b=KnErPYZ7rdJ9gM9s1U8MnxSZ7IVb3vIBtjP2kcT0nhisl07Qj/tFncivTR48tQc6gr
         T8BBZMbgFQuV37HfH0zJKjzRkSjKCdyMk6pw4jpqfXENi9CMOebWJNvmITBNr2JxpRKr
         qJXM15VEFvkKQLixhbdr2JcGqXHT+dc856vak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Jx2RoG3CrMolzndf4DS7yyJfX4Vfo8uS2SAXCzd4jH95BIq31VT763apqT2lpNV4mt
         AEcziQCmZWhywUI0omc7JmrrJBdY8v8Ba/dBEoJ+ijhfillFiPsKjjdmXwWWRJA8JnAO
         1b7lBDbe5G2kKzhg7h2kI1ifGRazSBaEgctJg=
Received: by 10.223.112.81 with SMTP id v17mr5958342fap.102.1298896736566;
 Mon, 28 Feb 2011 04:38:56 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 28 Feb 2011 04:38:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168104>

I ran `git-fsck --full --verbose` on a bare Git repository which users
push to (over ssh).

It reports things like this:

    missing commit c7836745b13ce838439b3705d3c5c93bc0add6a6
    missing tree ef59d2bee486b6af5ae36eb9ff2e9de0d52f37ab
    missing commit 786315c755ac91d3a1ffc3d92679dda961035617

But actually these things aren't missing. They were just pushed to the
repo after the fsck run started.

Is this a known limitation of git-fsck, is it documented anywhere? If
it's not supposed to do this maybe there's a race condition somewhere
in it.
