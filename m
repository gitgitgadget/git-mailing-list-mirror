From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 10
Date: Wed,  7 Jul 2010 02:14:40 +0200
Message-ID: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: dev-return-4816-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:13:51 2010
Return-path: <dev-return-4816-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4816-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWIGq-0004kv-6s
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:13:48 +0200
Received: (qmail 96132 invoked by uid 500); 7 Jul 2010 00:13:46 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 96124 invoked by uid 99); 7 Jul 2010 00:13:45 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:13:45 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.171 as permitted sender)
Received: from [209.85.215.171] (HELO mail-ey0-f171.google.com) (209.85.215.171)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:13:38 +0000
Received: by eyg7 with SMTP id 7so174601eyg.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M7kQK29ezflqac2lkaGiIADLMVTNRxKVbRc56U7xLQA=;
        b=ICOMOZcz0Od8se7Ms25eZ6/b5Jm/30/8VWIgntJo+mR2TkYt2seYVL0wZ6cb3IOymz
         B9nx4xNpb2bL8J65cP1dPdAGbsMQA7ta2eXpNdeYs6ArmgxCwoJbb1Zt1CUrQX937Cwv
         Cc6qPHJoDvKPKex37PR5yQuz0oJwHS0PihEUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=e4RaNssqGPfR2qq+Fy/liRy5/Qz8Du7wXr7iwhXn9b4au6jBKOFQY8o7gW+PH31+Eh
         poidRWV48MMPfv9dnBwGnSzWPM8+mAb5kjaSqG42BityRryn7xcRm8F2L7wz8z2IgCp3
         8QFYrTjSlt9HgGiVeCqiMVc4dKFlPOW2uJT8Y=
Received: by 10.213.19.82 with SMTP id z18mr4089813eba.74.1278461598252;
        Tue, 06 Jul 2010 17:13:18 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm55891726eeh.2.2010.07.06.17.13.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150425>

Hi,

After an extended weekend of hacking, I'm happy to report that I've
finally managed to finish the SVN client (now renamed svndumpr) and
validate it against 10,000 revisions of the ASF repository. It doesn't
look like I can go much further with the validation until the
dumpfilev3 parser is completed due to hardware limitations. However,
Avar has been kind enough to lend me access to a more powerful machine
on which I intend to run more tests over the next few days.

The last patch is a nice validation script; I would request everyone
who's interested in the project to test it against their repositories
so we can weed out any remaining bugs. The code is also available on
my GitHub [1]. Also, please review the series thoroughly and don't
hesitate to ask trivial questions: I'm new to developing with libsvn
myself.

Please note that it has been built and tested only against the
Subversion trunk: for Subversion 1.6, you can try using my
ra-svn-1.6. Also, there seems to be some unresolved issue on 64-bit
systems. We're working on fixing this.

Final note: I'll begin preparing to merge this into the Subversion
trunk soon.

Thanks for reading.

[1]: ra-svn and ra-svn-rollout branches of
github.com/artagnon/svn-dump-fast-export

-- Ram

Ramkumar Ramachandra (13):
  Add LICENSE
  Add skeleton SVN client and Makefile
  Add debug editor from Subversion trunk
  Add skeleton dump editor
  Drive the debug editor
  Dump the revprops at the start of every revision
  Implement open_root and close_edit
  Implement dump_node
  Implement directory-related functions
  Implement file-related functions
  Implement apply_textdelta
  Implement close_file
  Add a validation script
