From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: clean/smudge filters for pdf files
Date: Thu, 23 Oct 2008 15:44:39 -0400
Message-ID: <ee2a733e0810231244u1510cdc8y7b27af9b8fdda1e0@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 21:46:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt685-0004lM-1L
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 21:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYJWTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYJWTon
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 15:44:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:33614 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYJWTon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 15:44:43 -0400
Received: by ey-out-2122.google.com with SMTP id 6so162202eyi.37
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+/1dtMptr5vOYyOLp5G+mFYqy/eftk7AwwU1cDFG5rU=;
        b=G0nAbxCMIqiOnP+KRrWJvNctULhf12mV70zJe5j+shlDdT4e5KZZupVbSBwtVxdfQT
         vEsyOZVqDmOcPne+EBS3EtfXioymSgSuBgl7H3xrES80vJen1alHqiEnVkx0tqaYW8aY
         CND4z14qIfEa1PsF9Nok0dlE2a2EgB8sCeJmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Gq6upGi8vVTziv2c3SNs0WV6ysCjchCngcVZG/T/xD12I69bMQOcNoGSCAUZ2BxFuW
         oo8080eggBUduFI+D+dChvr0Iq0zKcgzxhXd/kMq2HaCX1lKROe8F16B//Lk5n5+rrPL
         cMOGHJfSXOXvkaWRhmk32etU6nEstlKqZKXKo=
Received: by 10.187.241.11 with SMTP id t11mr1659far.5.1224791079658;
        Thu, 23 Oct 2008 12:44:39 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Thu, 23 Oct 2008 12:44:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98986>

I am trying to improve storage efficiency for PDF files in a git repo.
Following earlier discussions in this list I am trying to set up
proper clean/smudge filters. What follows is my current setup

# in ~/.gitconfig
[filter "pdf"]
	clean  = "pdftk - output - uncompress"
	smudge = "pdftk - output - compress"

# in .gitattributes
*.pdf filter=pdf

Unfortunately, it seems as though that pdftk uncompress followed by
pdftk compress do not leave the file invariant. I tried several
uncompress+compress iterations and the file still keep changing (the
size though stays the same).
Is there any other alternative way to store PDF files in git repo more
efficiently?
Any alternative to pdftk on Linux?

--Leo--
