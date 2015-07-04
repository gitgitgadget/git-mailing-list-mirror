From: Luke Diamand <luke@diamand.org>
Subject: Re: [git-p4] import with labels fails when commit is not transferred
Date: Sat, 04 Jul 2015 04:27:25 +0100
Message-ID: <5597529D.9080100@diamand.org>
References: <A24B2157A13A04409644C1456B5AE27F1CE4B663@DEWDFEMB19A.global.corp.sap>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "Holl, Marcus" <marcus.holl@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 21:24:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB6ZW-0001u2-0c
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 21:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbbGCTYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 15:24:22 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35640 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbbGCTYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 15:24:19 -0400
Received: by wgjx7 with SMTP id x7so94805653wgj.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ZrZHRero7i47sIaTIgC2gCY94ZexjAJOLEBHumYjS/U=;
        b=YWOdTlN7l3EdIVmPcn8mctp0ergJ/v8WRAKVrP+QqoKWw91qcllSOw9OZKvXeoot2O
         2uFZZSY3GtnJyRzCnEdf20MWOusBCVBCNkBbumbbC8dw+vkHLGuECW4GsNl83SJyLQqb
         AUJdLbe+Rdr4Kv28uEy930er0GWqPaKqpTlME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZrZHRero7i47sIaTIgC2gCY94ZexjAJOLEBHumYjS/U=;
        b=kqj5Kibq0YdAGjZHQil8LF0V60RjUUILsO/k28vYxWZfzIlHlDXzKplGp4sBulIBLy
         K36dDKbT0o6+aq1007WqL271Qlhhpxk19p2ixgq5rP72lPjcQuW4q12MzJh8DBH9TiJA
         9ncthhMB76YghGi4t8c81VMzk1ZcnVhvMPi3AeCxVMBmtgoK/V3ODooZOkTeziassxeC
         SB2lxcP3INUF1rGwWR9V/223DjegD4aTpKgBrGzudVy0J5/PoCupjFcBgqosAIMK55m2
         E4eFGjaExtPOa6VPg28Yf2WV0onT4Z3PZ0kQ4IpH0pquhXNXRkgTlswd7vy6XYquraGN
         IG2g==
X-Gm-Message-State: ALoCoQmmhGxwrvr/Ug1EMRUCj8y/wqQSzf/mFDswDA7FxskGOKS6nDHhmlXNduP3zpSik4YrfGGC
X-Received: by 10.180.91.107 with SMTP id cd11mr27696887wib.51.1435951457975;
        Fri, 03 Jul 2015 12:24:17 -0700 (PDT)
Received: from [192.168.245.39] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id p2sm15203311wix.11.2015.07.03.12.24.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2015 12:24:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <A24B2157A13A04409644C1456B5AE27F1CE4B663@DEWDFEMB19A.global.corp.sap>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273312>

Sorry for not replying earlier, and thanks for taking the time to 
investigate this!

It's a pretty subtle corner case: I think a test case would be useful. 
I'm going to try to put something together, unless you beat me to it!

(I think t9811-git-p4-label-import.sh is the one that needs extending).

Thanks!
Luke

On 30/06/15 09:45, Holl, Marcus wrote:
> Hi,
>
> I have an issue with the git p4 tooling regarding import of labels.
>
> My git version is 2.4.5
>
> I try to transform a perforce repository. My command line is:
> git p4 clone --verbose --detect-branches --import-local --import-labels --destination <DESTINATION> //depot@all
>
>
> The relevant parts in the gitconfig is:
> [git-p4]
>                  branchUser = <USERNAME>
>
>
> For that user there is a branch mapping defined with a lot of entries like:
> //depot/trunk/... //depot/branches/ipro-status-8-2--branch/...
> //depot/trunk/... //depot/branches/9-0-preview/...
> //depot/trunk/... //depot/branches/release-8-0-0-branch/...
> //depot/trunk/... //depot/branches/release-8-1-0-branch/...
> //depot/trunk/... //depot/branches/release-8-2-0-branch/...
> //depot/trunk/... //depot/branches/release-8-3-0-branch/...
> //depot/trunk/... //depot/branches/release-8-4-branch/...
> //depot/trunk/... //depot/branches/release-8-5-branch/...
> ...
>
>
> The import fails with the log output that can be found at the bottom of this mail.
>
> git log -all -grep "\[git-p4:.*change\ =\ 69035\]" reports nothing. The commit is not contained in the git repository.
>
> p4 describe for changelist 69035 returns a reasonable result. This change contains one file located at a path in the perforce folder structure that comes without corresponding entry in the perforce branch mapping.
>
> According to the given branch mapping it looks reasonable to me that the change is omitted in the git repository. But in my opinion the import should not fail in such a case.
>
> A reasonable behavior would be to blacklist the label (add it to git-p4.ignoredP4Labels) and to continue with the next label.
>
> Attached is a proposal for a fix that needs to be carefully reviews since I'm not that experienced with python.
>
> Other proposals for resolving this issue are highly appreciated.
>
> Thanks a lot and best regards,
> Marcus Holl
>
>
> Log output:
>
> Reading pipe: ['git', 'rev-list', '--max-count=1', '--reverse', ':/\\[git-p4:.*change = 69035\\]']
> fatal: ambiguous argument ':/\[git-p4:.*change = 69035\]': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ied with change: 69078, original Date: 2010-04-22T09:07:24.000000Z\n', 'Update': '2013/11/02 07:40:31', 'Label': 'release-8-1-0-976', 'Access': '2015/06/26 14:50:15', 'Owner': 'svn_p4_converter', 'Options': 'unlocked noautoreload'}
> p4 label release-8-1-0-976 mapped to git commit 82a11809928b86a7bde03cf486428de52ab3380f
> writing tag release-9-0-0-179 for commit fb8370cd04806686c567ad720d065436f2334b4a
> labelDetails= {'code': 'stat', 'Description': 'Created or modified with change: 96984, original Date: 2011-12-22T16:01:25.681427Z\n', 'Update': '2013/11/02 15:15:50', 'Label': 'release-9-0-0-179', 'Access': '2015/06/26 14:50:16', 'Owner': 'build', 'Options': 'unlocked noautoreload'}
> p4 label release-9-0-0-179 mapped to git commit fb8370cd04806686c567ad720d065436f2334b4a
> Traceback (most recent call last):
>    File "/usr/lib/git/git-p4", line 3297, in <module>
>      main()
>    File "/usr/lib/git/git-p4", line 3291, in main
>      if not cmd.run(args):
>    File "/usr/lib/git/git-p4", line 3165, in run
>      if not P4Sync.run(self, depotPaths):
>    File "/usr/lib/git/git-p4", line 3045, in run
>      self.importP4Labels(self.gitStream, missingP4Labels)
>    File "/usr/lib/git/git-p4", line 2421, in importP4Labels
>      "--reverse", ":/\[git-p4:.*change = %d\]" % changelist])
>    File "/usr/lib/git/git-p4", line 138, in read_pipe
>      die('Command failed: %s' % str(c))
>    File "/usr/lib/git/git-p4", line 106, in die
>      raise Exception(msg)
> Exception: Command failed: ['git', 'rev-list', '--max-count=1', '--reverse', ':/\\[git-p4:.*change = 69035\\]']
>
