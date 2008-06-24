From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 14:15:49 +0300
Message-ID: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 13:16:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB6Vy-00072i-Qw
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 13:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYFXLPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 07:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYFXLPu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:15:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:35179 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYFXLPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:15:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7607160rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Jn6xY/NqG7VB+92OJOoyaoPl0vJw9J++j4Ap/2vsW6s=;
        b=UGzre8NMJxU6sjYt0hqaxd0FkkhSB433VUAb9tYZJosGIdBUnGulmAtxT6KOXVvi7i
         M/DhsUqc05AWFD0Ebj63RdSy/ePWFPcRzzY9kKa3GoKF9Snfw+ULup1fh9x9PIKoeSao
         LxLWhxcM2TygkU+6hfQOcLWNTO1TcSghwCqZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=v9IkA1Eq3OMBcOeWuYbfITm6332vtmVpTKIbQpfiudt+HJ0iMhZjKqKOckJ0rnUO51
         YdlqXmOhJ3Hajvfxv35cTbNROnbiucUtd5I1FMDOAPUOX+ekVVQX4id9wuLs0mkEaGa4
         a8BrTn0XGjGowG5BPDekglliAQpup0M+Fz2k0=
Received: by 10.141.3.17 with SMTP id f17mr14577705rvi.180.1214306149327;
        Tue, 24 Jun 2008 04:15:49 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 04:15:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86033>

Hi,

I'm able to git-clone a tree using ssh:

[root@kd001 t]# git-clone
ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
erez.zilber@kites's password:
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 9 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (9/9), done.

However, it doesn't work with http/https/git:

[root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

[root@kd001 t]# git-clone https://kites/pub/git/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

[root@kd001 t]# git-clone git://kites/pub/git/erez.zilber/my_test.git
Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
kites[0: 172.16.1.11]: errno=Connection refused
fatal: unable to connect a socket (Connection refused)
fetch-pack from 'git://kites/pub/git/erez.zilber/my_test.git' failed.

What's the problem?

Thanks,
Erez
