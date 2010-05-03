From: Paul Lindner <lindner@inuus.com>
Subject: git-svn error: ambiguous argument
Date: Mon, 3 May 2010 13:51:09 -0700
Message-ID: <7A6370FC-843B-43FD-8064-4F44C9C66493@inuus.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 22:51:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O92cE-0007Sz-Uo
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 22:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab0ECUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 16:51:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51176 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab0ECUvk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 16:51:40 -0400
Received: by gyg13 with SMTP id 13so1382153gyg.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 13:51:34 -0700 (PDT)
Received: by 10.224.79.38 with SMTP id n38mr1329783qak.204.1272919894309;
        Mon, 03 May 2010 13:51:34 -0700 (PDT)
Received: from [172.16.27.141] (dagmar.corp.linkedin.com [69.28.149.29])
        by mx.google.com with ESMTPS id bv23sm851565qcb.19.2010.05.03.13.51.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 13:51:28 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146255>

Hi,

Since the 1.7 time frame my git-svn imports have stopped working after a period of time.  The error that crops up is:

  trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' 'd18d09558e4f56fb757b258cb364f38861f84116' '3f498379030b5358d65820415b98cbe338086247' '1e4ed9c6fde9e4b2465a8db6915f32a132634064'   'a51029a8667288556e02055057f250157e0a7f59' '0a7934d4a22563e29ed9857240bc022800f626f7' 'c6a0edb91eed10b86aad74c138422ff8a496ad29' 'd211954a973b92feef86aa130bf5ac253c095574' 'd9e99745569c8cd7d087cd8740f915b34f0f5fa2' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
  trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' 'd18d09558e4f56fb757b258cb364f38861f84116' '3f498379030b5358d65820415b98cbe338086247' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
  trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
  trace: built-in: git 'merge-base' 'd86892a76b3ef4049b87ca50f62846cdff5f204f' 'cb612e24c7d15ff8b4b13822592fff25e1efff13'
  trace: built-in: git 'rev-list' '--no-merges' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' '--not' '23dfc0fd04cedd8e09c2bfa6f0e79e9a4282bc57'
  trace: built-in: git 'rev-list' 'dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764' 
  fatal: ambiguous argument 'dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions
  rev-list dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764: command returned error: 128

This git-svn repo is a shallow clone of a very large svn repo.

It was initialized like this:

  git svn init SVNREPO --trunk=network/trunk --branches=network/branches --tags=network/tagz --ignore-paths='^.+/(?:branches)/(?!BR_ENG_PLFM|BR_REL)' network
  git svn fetch -r 112002 

It appears that one of the branches cannot find it's parent:

 git log dde42274ac34e4055275ea4926cd8cc259476399^

fails.

Any ideas or workarounds would be very welcome.

Thanks!
