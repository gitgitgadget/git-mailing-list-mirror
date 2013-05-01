From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Wed, 1 May 2013 23:51:04 +0400
Message-ID: <455264907.20130501235104@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXd59-0003Ls-8O
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab3EATws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:52:48 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:61504 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab3EATwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:52:46 -0400
Received: by mail-la0-f45.google.com with SMTP id el20so1597775lab.4
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=R9+I6a6E/09s8GIYA4+j9RgGbvJppQDQnNOwfk2CLDg=;
        b=oa698ZFCsAFZ0ky6+FhKG8Cq9KnYRWzvikfCvsXpRJRyhyJ3AbYXAt9qNxS+Vg80Pr
         zyBmZexRb7Ve0o1L9e0CT8fP0Lvcw4wXVu1l/Jcy2sgxfLAa6cqF5kPv4lzorO/OEIo9
         fNX80BWBWEhOfC2w3I0yJzpznUynaobiWnR3PUhw9pd2ijmBtjUP8QvITCaWapQtCgjK
         QNqkeUK6OMqVPls/tiVQ320xK5D5gkGYL+ZOTMTp8h0e7+IvV6EZxc07Y8I4W2M3Ip3t
         XU4ZL6KRq2CObhyG7CZ4JeuD/+iyPUZnaw2wcijeRTGsNehmTRg3Lk0XP4XapRDSjAFy
         xe3A==
X-Received: by 10.112.125.164 with SMTP id mr4mr1238119lbb.116.1367437965099;
        Wed, 01 May 2013 12:52:45 -0700 (PDT)
Received: from [192.168.0.78] (92-100-238-23.dynamic.avangarddsl.ru. [92.100.238.23])
        by mx.google.com with ESMTPSA id w9sm1731868lbe.6.2013.05.01.12.52.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 12:52:43 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <7vhaim8w48.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223133>

JCH> ...and you want to perform a merge on the
JCH> Git side of that branch with another Git branch that does have real
JCH> contents in that directory, you would want the result to say "This
JCH> directory no longer is just for a placeholder", but you cannot say
JCH> that globally by updating the config file
Placeholder files are managed when fetching from SVN. SVN doesn't
support Git-like merges.

JCH> comment line "# added by git-svn only to keep the directory" and
JCH> consider a directory that has nothing but .gitignore that consists
JCH> of only that exact comment line an "added placeholder" directory to
JCH> work it around.
Sounds good, but it's not I who decided to use the config file.


-- 
