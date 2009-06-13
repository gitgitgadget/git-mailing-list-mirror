From: Marco Nelissen <marcone@xs4all.nl>
Subject: running git as root
Date: Sat, 13 Jun 2009 08:25:47 -0700
Message-ID: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 17:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFV7j-00079L-T0
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 17:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760095AbZFMPZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 11:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbZFMPZt
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 11:25:49 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:44686 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762036AbZFMPZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 11:25:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so5867401and.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5eUt0ybFBQOAYe7NUhJBF+zYtqPvwlMSiot3gtnRrcY=;
        b=JB+a7PM2OYGGl7ZNXWfgay3nZF5S+PwUutBNamZZGbfVWv1w8/ZrJvKxKW27odFm5b
         IXif4qdjOAQGB8ebT0kGnertKUyDlyqTc7rMj/0L/LjSbk0QFpgZM/Fp0HEQz5IjFdy4
         DMUfeXSKIEEKE/MAxGlAPutkzn5DLyZ4B6H5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=NIbgB0HBclaqUAHub+g1j56jH2TuZUJZU3leyn5vjJ02Zey9q4JsHQXsNdCZYH4TRE
         xWsogo7DqFevW8ykse9k2xwaGUMGoLxIos18Le9QCXe3ufSZ0ibkUvn65TLAQGiHUi2f
         O9I15s03nuDOpvHmG3X5mT16Xn0Ofm7d+DxFA=
Received: by 10.100.92.16 with SMTP id p16mr4452484anb.136.1244906747914; Sat, 
	13 Jun 2009 08:25:47 -0700 (PDT)
X-Google-Sender-Auth: d75b54de1cf61ed4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121502>

When running as root, git fails a number of test cases that expect it
to fail on read-only repositories (for example 't0004-unwritable.sh').
I was thinking of either changing the code so that it checks
permissions itself when opening files as root, or add a prerequisite
to those test cases so that they are skipped when running as root.
What would be the preferred way?
