From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v5a 0/6] add new feature and option command
Date: Thu, 27 Aug 2009 11:40:25 -0700
Message-ID: <1251398431-12461-1-git-send-email-srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgju5-000710-7L
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZH0Skr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbZH0Skr
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:40:47 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:54967 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZH0Skq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:40:46 -0400
Received: by ey-out-2122.google.com with SMTP id 25so303985eya.19
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=fcHUTRdwoywrrh/NqKwe6/8aXyxP6uaR/mPsCcSxdxs=;
        b=PlpIg4x91J3FMMigvV2JwrhTB7TPVWs+bgOPvb8bjNerVM+pOw9PLJx+VbpDkUJo2s
         TUlWtKdXdl1980m5gGOy1bUQy4zqJZLnG/h7/u3BT3J7emQFi3sSmCr1poIMtOl7Fv9/
         hLrkOuZ08CQsST+VLlrRRJawcrik77ikBaqgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=vAhALwkPqiru6IaX7MfYqd+EbIrVrh0Sp9LuoGHp1QmFHxqVDIK5r19x6fj8WuwsIA
         6aFzLQIJM5sky88hznggTjyKHKTqXZAizvonMjJvTUpHYQKuRj9VWOUo62uC6kGrYvYQ
         kIBsMstFDFSrD0gjWWqTvz4Fto6nVTHjNfMN8=
Received: by 10.216.51.82 with SMTP id a60mr22722wec.108.1251398447547;
        Thu, 27 Aug 2009 11:40:47 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id i35sm1687558gve.26.2009.08.27.11.40.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:40:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127189>

Apologies for the borked v5.

This is a reroll of sr/gfi-options to include suggestions from an
off-list discussion about the fast-import format.

Reworked the series (compared to v4) to introduce a 'feature' command
first, and use that in the new 'option' series.

Sverre Rabbelier (6):
      fast-import: put option parsing code in seperate functions
      fast-import: put marks reading in it's own function
      fast-import: add feature command
      fast-import: test the new feature command
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   39 ++++++
 fast-import.c                     |  255 ++++++++++++++++++++++++++-----------
 t/t9300-fast-import.sh            |   86 +++++++++++++
 3 files changed, 303 insertions(+), 77 deletions(-)
