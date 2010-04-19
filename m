From: Arnauld Van Muysewinkel <arnauldvm@gmail.com>
Subject: [QUESTION] or [BUG] Could not stash new bin files
Date: Mon, 19 Apr 2010 10:19:25 +0200
Message-ID: <p2rc8485ef11004190119q590aea5dy516bdc3d222ebb51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 10:19:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mCv-0000SC-6l
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab0DSITs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:19:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:9674 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab0DSITr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:19:47 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1818061fga.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=LlU4HK+Bglof0i9NP6GEc8HPeNuFAwp8ynJXbnBAjIE=;
        b=OkIW3ju+VakW3uL5wJ1J1rIFDAnd5FzTSBFLn1vA/d9EZbRONSWf/iYOR2y4dgDAfR
         7HschctRq50qCIa7rtgELdMXlcA4fMaB3Cfh1DqRLDoTef6mF6/SARBlZuBP5f2ULmNe
         t+d2rA3tHwnNQhGa2XQ3ix99eGtYxJfTjfx8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=KoC8QXmtr1+EEJ7/mnbvv2sjN3OiuEgBfouiW/uaoA/d2YS2u0BdCL+I6SnH2jHfZB
         Db/n07XE7QX35DFJNh5lY4fuuMo7x6CCUqXbdSMHreQH+FQr4/8zTb7RW+k5YMgfnXNl
         Y/upsnWmOtX25cXbpq6LZZmfyOXktDR+mBRa8=
Received: by 10.223.116.76 with HTTP; Mon, 19 Apr 2010 01:19:25 -0700 (PDT)
Received: by 10.223.17.136 with SMTP id s8mr2519903faa.41.1271665186301; Mon, 
	19 Apr 2010 01:19:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145278>

I'm quite new to Git (using it since a few weeks only) and really like
this tool. This is a great improvement over Svn that I was using until
now. (Still using it for the company master repository though.)

I have the following problem:

I want to stash new files. I tried the combination "git add" / "git
stash" but it does not work. Did I do something wrong, is it a special
case, or some kind of bug?
Does anybody have a clue?

Here are the details:

    $ git add -N XXX/src/jrxml/*.xls
    $ git stash save --keep-index "Improving performance of views"
    XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-new.xls: not added yet
    XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-old.xls: not added yet
    fatal: git-write-tree: error building trees
    Cannot save the current index state
    $ git status
    # On branch MS9
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       modified:   XXX/.settings/org.eclipse.wst.common.component
    #       new file:   XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-new.xls
    #       new file:   XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-old.xls
    #
    # Changed but not updated:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working
directory)
    #
    #       modified:   XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-new.xls
    #       modified:   XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-old.xls
    #
    $ git version
    git version 1.7.0.2.msysgit.0

Specificities:

* I have a file in the index that I do not want to stash
* The two new files are binary files
* I'm running this on windows (msysgit)

Please tell me, should you need any extra information.

-- 
Arnauld Van Muysewinkel
