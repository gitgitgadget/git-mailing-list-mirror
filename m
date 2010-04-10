From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Local unset override global options
Date: Sat, 10 Apr 2010 07:54:28 +0100
Message-ID: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 08:55:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Uaz-0004Qn-3X
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 08:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab0DJGyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 02:54:33 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:47313 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab0DJGy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 02:54:29 -0400
Received: by qyk9 with SMTP id 9so2209828qyk.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=0f96GFERFcZrRgoPgOLQZFIEHTxVz3/3+aygPeCzYoE=;
        b=QDMwOL7Rak79++50jc2EdEowIblVjclQ9gKujVDcD/18a2Z6ze6WpPn+VIjERiffJp
         /0W+6s2cSJRgaqzz4dWjmaz/oZjcdpz5fvaH02Qu8H7bNOOOrZTLcOyi3Zzl/CFBqRH1
         A5fvDaup3uTyB5CyyvWN744ejuZ4aGCOEizHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HdEpH88P+xWd/wCelcd4fJFqthjFf+i8Q/MeeLH22Z6NB5k0bKGwb0n8Oy+eBGFynU
         2+a3rdFP2CEwmJeCI3shPE8JDTbhF3lavJTARSrOQQARSKy3z3Ed2amkjL3EPrnh3Z89
         g0/Aw1Zq1RGbxd7rfik23gLleEoKF5ojmOxPM=
Received: by 10.229.223.196 with HTTP; Fri, 9 Apr 2010 23:54:28 -0700 (PDT)
Received: by 10.229.190.21 with SMTP id dg21mr1604847qcb.69.1270882468127; 
	Fri, 09 Apr 2010 23:54:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144521>

I have default settings for sending email in the global git config.
However, for one repo different email settings are necessary.  That
specific SMTP server does not want authentication, therefore smtpuser
should be unset.

The issue is that global smtpuser is set for the default SMTP server
and unsetting local smtpuser results in the global smtpuser being
inherited.  What I'd like is smtpuser to be unset for this particular
repo.

Is there any way to "unset override" options locally?  If not, is this
something that could and should be implemented?

Stefan
