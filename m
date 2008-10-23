From: "Felipe Carvalho Oliveira" <felipekde@gmail.com>
Subject: Tip: avoiding net overhead using git over sshfs
Date: Wed, 22 Oct 2008 22:26:18 -0300
Message-ID: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 03:27:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksoz7-0003mi-M9
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 03:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYJWB0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 21:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbYJWB0U
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 21:26:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:22841 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYJWB0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 21:26:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so85589rvb.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 18:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=wFQ6S5rmHuVLpYs5K6NIBIwOtnlXyQWhfMVmSdknTyk=;
        b=G95XhiGwVLT1YdWXWmuRPHSW4Zp00xF5WxLwYDCXLhSduGhJIeswEGlxU8QEmOos0p
         LyqpEepG/crEPMaxr8z6bTKzdxxXQATZuebiAjlkqP8AuR689bS9UdVcPJIOxDuF90aH
         YhyHYPlNO14PS/Kg/QTTX8VZGWBjFFCaAI7ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Uxau+sO/+xRvgwVgWn6h8hnV1chPnk2OKRbykMUpwcPr/TSwZJo875uKvJjrAGsM7n
         Zf63JqqwKN/cZ6aV5F+TIE7w09bJAhjv+qm1kBVNm5pxr7IvxCPjfc02V0A7DibrgWzv
         KcqZnn3lW8zySkONpA6sRMMFraT1e7dwVlRO4=
Received: by 10.141.122.1 with SMTP id z1mr4380318rvm.161.1224725178537;
        Wed, 22 Oct 2008 18:26:18 -0700 (PDT)
Received: by 10.141.116.9 with HTTP; Wed, 22 Oct 2008 18:26:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98937>

Use git over sshfs is not so good, but is an option for people that
don't have shell acess to the server/hosting like me.

# mounting
sshfs -o workaround=rename <user>@<host>:/home/<user>/  <mount_point>
cd <the_directory_of_your_project>

# we will move the .git directory to the local filesystem
mv .git ~/.my_project_git
# and create a symlink to the local .git
ln -s ~/.my_project_git .git

Done!

Now you can open gitk instantly ;-) and don't need to have the entire
.git thing on a remote filesystem.

         Felipe (from Brazil, my english skills aren't so good :-)
