From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: git svn .git/svn/*/index files taking up huge amounts of disk space
Date: Sat, 18 Jul 2009 09:58:05 -0500
Message-ID: <CFF1FF99-9237-4C89-BB2D-66F82CF683B1@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 16:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSBMr-00078u-K5
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 16:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZGRO6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 10:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbZGRO6K
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 10:58:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:65335 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZGRO6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 10:58:09 -0400
Received: by rv-out-0506.google.com with SMTP id f6so382808rvb.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=/pVud/gYq1iN/BBssG4vm6Nd4dLhKgaUPYmrpK/3A7Q=;
        b=ht73LZNpf8TCh5H7QtWlv+09ia4hdIL/zIPXt3iyBQgCTT7F+tFqXgwtsBIaY60VOL
         8uUIlgkdnx9cPQlyhPAFng0j1G3vnMOQlAQPjd7AcNFRutEO0K2Xn8JEtNE2d+Dh7MLD
         tl6wXrvMRzK+kCaKGFD6/Jd5sR1YvFoHFjMFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=PW4o4r7bXapuoXqGlvEoKTQ79t+RwPV6Y+8m+rBt18NEzg/ckfk7e6wF8mUWiAE1p1
         ZkjUo6HQKkB92iDdryRCOiUzpiDW202PiC6Ln/5yiVpZEzgsJ+3R9/teXhmn++ojwCkZ
         7PSYMzxNV6H55R7vuMue8LBL6PPAyG3kf2+vQ=
Received: by 10.141.52.9 with SMTP id e9mr1532286rvk.102.1247929088191;
        Sat, 18 Jul 2009 07:58:08 -0700 (PDT)
Received: from ?10.0.1.199? ([66.250.141.2])
        by mx.google.com with ESMTPS id f42sm11704755rvb.5.2009.07.18.07.58.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 07:58:07 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123523>

I have recently imported  a Subversion repository with   
1.6.4.rc0.17.gd9eb0, and ran into an interesting tidbit.  The .git/svn  
directory is the largest directory, taking up about twice as much  
space as the .git/objects directory.

Most of the space is taken up by index files under .git/svn under .git/ 
svn/tag or .git/svn/<branch name> directories in the subversion tree.

The repository uses the normal Subversion layout (trunk/tags/branches)  
and was setup with git svn init -s.  There are a lot of tags in the  
repository - about one per day for the past several years.

What are the index files under .git/svn used for?  Am I doing anything  
wrong?  Can the index files under .git/svn be safely removed?  My  
brief look at git-svn.perl makes me think that they are temporary, but  
I'm not sure.

Thanks,
Robert
