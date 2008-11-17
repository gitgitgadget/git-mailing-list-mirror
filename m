From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: [ANNOUNCE] New fast export tool: rcs-fast-export
Date: Tue, 18 Nov 2008 00:24:33 +0100
Message-ID: <cb7bb73a0811171524n24acf812q9dbc78b5da6890e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 00:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2DTg-0006bI-2a
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 00:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYKQXYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 18:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYKQXYf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 18:24:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:29238 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYKQXYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 18:24:35 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1292275nfc.21
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Vo9zGYBWhA9/vIH2Bg6muW0R44b7V0aOZ5HKcFrmICM=;
        b=CdY0AaIETkIT94oqQbV13CqS1U0a9X4V0dCNM1GT5aua85ux+w4p5iVNr8igRXOidY
         UWPxLzNh8IHrjDtGeEX7jw/rOp++4pYkyxyjwm/Dy41BsnZ84YvzkEqeZcYzDUQB9EYw
         Qc58mtfOzcR/nRr0KnkUSFBvBJlnhLvejkzeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KnAbUC6shjBOVYgMvT6QBB2Yfp2EX7cQV9d0juofpJWrw1kJXFGjrxq/FA7DqAxrVY
         y4UUeygb7n8ClFZLgYYyAYwyQTlo/vkkVCS40XPV3gVLwC/dvUl2RbXKnqFPwUSJ3uqL
         AcdSOnRi/wCrmVIUdT740OYp3j0/1b32axeig=
Received: by 10.210.62.12 with SMTP id k12mr4401526eba.70.1226964273112;
        Mon, 17 Nov 2008 15:24:33 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Mon, 17 Nov 2008 15:24:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101255>

Hello all,

I just finished giving a decent form to a tool I've been longing to
get my hands on for quite some time: an RCS fast exporter
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#rcs-fast-export

It's written in Ruby, and doesn't require any external tools or
libraries, parsing the RCS files directly (hopefully correctly). It
converts RCS symbols to lightweight tags, it supports your typical
--authors-file, it can even (lightweight) tag every commit with the
corresponding RCS revision, on request. It follows branches, too,
giving them a name like 1.3.2.x. You *can* process multiple files at
once, but the script will not try to do anything smart so the results
might or might not be what you expect.

TODOs include
 * not needing an authors file for users that had the good sense of
configuring their user.name and .email properly and whose username is
the only one appearing in the RCS history
 * being smarter with memory management because we already exports
blobs on the fly so we should discard them unless they are needed to
rebuild other RCS revisions
 * integration with Zit, the Git-based single file content tracker, so
that you can say for example 'zit import somefile' where somefile is
RCS-tracked
 * submission for git's repo (to contrib)
 * submission for fast-export's repo http://repo.or.cz/w/fast-export.git
 * test with fast-import for other SCMs

-- 
Giuseppe "Oblomov" Bilotta
