From: James Pickens <jepicken@gmail.com>
Subject: 'git clone' doesn't use alternates automatically?
Date: Fri, 30 Jan 2009 15:12:42 -0700
Message-ID: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT1co-00040v-UQ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbZA3WMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbZA3WMo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:12:44 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:60660 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbZA3WMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:12:44 -0500
Received: by wa-out-1112.google.com with SMTP id v33so312619wah.21
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=knvVPksZeDTGARRzQlbFRUxMCy4z6dSBSmf2NyOS724=;
        b=VQrSUjWVFCJFV6ZtFid6yWftb/R3hbXm6KCaWGfrg5nRfiC/6OMYlRD8NITc63nAB+
         K0ihX8gAHChhk6Sj0798DqcAAwJrmRP84c+13xURl8Gwv2Nll2tFJJyupZ8Kb+z3KoS6
         hpuoesPUXiSa4rKghnr4EmdmjlUHDzjt5sx7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oNXCVJHRn+9K7nTydnf92Fr00947ev/dSxKsuIdJ9ShfAu8cTbl3eT6/4HlEZR5VLv
         6+COr74EG7xN8+yU0PQtRbZAOes7TTC0/+kn++GqLpEkg1GRxp8Iu62tWX4Y4r52AETp
         CGENIa48mBir4UmdDsYvncxgEDRwW6h+dwhpI=
Received: by 10.114.211.17 with SMTP id j17mr1081546wag.61.1233353562615; Fri, 
	30 Jan 2009 14:12:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107874>

Hi,

I have a central, shared Git repository on an NFS drive at path
$central.  I have added "$central/objects" to
$central/objects/info/alternates.  I see that when I clone this
repository with Git 1.6.1, the alternates file is automatically copied
to the clone, but so are all the pack files and loose objects.  If I
then cd to the clone and run 'git gc', it removes the redundant local
objects.

I thought I tested this setup a few months back, and 'git clone'
automatically used the alternates file to avoid copying the redundant
objects into the clone.  Has this behavior changed, or is my memory
bad?

James
