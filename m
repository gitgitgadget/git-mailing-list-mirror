From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 0/3] fast-import: add a new option command
Date: Thu, 13 Aug 2009 12:02:33 -0700
Message-ID: <1250190156-4752-1-git-send-email-srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:03:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbfZq-0007Q3-U6
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbZHMTCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbZHMTCw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:02:52 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:55125 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbZHMTCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:02:52 -0400
Received: by pxi34 with SMTP id 34so95478pxi.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=aU8hMM2oCrTromdSnKlpF+6At+jqaclsiVXCtqXecAw=;
        b=VSY8gI/VIN0mwLx7TLNTpJq+JP9Bpu3l6aI+eCH9//391Hxq0VCbuYKiYPDBmaWmSI
         LwsRB//omMZUpAsUzAieqXpocxIV/DpZY8k0GE/aq+vpJaO9tE0cQvMr0i4VoQ8llbGH
         7ixffcCpAcaHV0QRD16RgajerCEi7vSAH5yH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=VyyAk7WTz7tUqDTi1TqHTBGDYmsE3Ow8eQu8p/0//WMTSrQcc/djSOpRbmhAuthHPZ
         ArPKWm948/sO7ntG7I9y8ca5BiJXAwSXVnokxYSPuUeUQ3NlJXfqtLI0GBoeLHA2wpVT
         7Hl4PU1FeFASPy5SlQHxYHESCGMX1HZqjSvVQ=
Received: by 10.140.202.12 with SMTP id z12mr652404rvf.68.1250190172928;
        Thu, 13 Aug 2009 12:02:52 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id f42sm3575374rvb.35.2009.08.13.12.02.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 12:02:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125851>

Now we delay reading the marks file till option parsing is done.

Sverre Rabbelier (3):
      fast-import: put option parsing code in seperate functions
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   23 ++++
 fast-import.c                     |  235 +++++++++++++++++++++++++------------
 t/t9300-fast-import.sh            |   58 +++++++++
 3 files changed, 239 insertions(+), 77 deletions(-)
