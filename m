From: Liu Yubao <yubao.liu@gmail.com>
Subject: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 16:55:48 +0800
Message-ID: <49082514.9050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 09:57:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv6rW-00081O-Tf
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 09:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYJ2Iz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 04:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYJ2Iz5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 04:55:57 -0400
Received: from ti-out-0910.google.com ([209.85.142.185]:39703 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYJ2Iz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 04:55:56 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1618266tic.23
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=QvlAYGdKCXsI9DcJCNRbXjTQv9cGerZ72oOneJBNbxM=;
        b=BMU1HX0l0DY2yJWaAe/vhtBfiCkWiRUTN8B7xq3HVVafsVFfrJextC6VZZETHNY6ZJ
         MSG4TsdqswIXw3mAMz9dB6JrbBni4N3SKGTQt1tlqttKMxezPjGPI+ez4AXrzN4S7UE4
         PGvAIxoKiHvr8TjSY9uN/KEXsaF94w1kqN5Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=WoQ2V1XqO3KudhwXwfscvuSKLVoJOkJR6WuFF1lZoLLL1BISZmLunBb5cGYQ4XAp3T
         w/fBxaykgNJnX1KjTahzDv9YuAgTwtyz61dLYBGH5IEjSfABpyvhefS05yF2BffIsdEg
         HuK4jjWlJINfPj5wNhgn20RuTToUXc1n5z5ag=
Received: by 10.110.53.14 with SMTP id b14mr5507058tia.45.1225270553866;
        Wed, 29 Oct 2008 01:55:53 -0700 (PDT)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id 2sm5243281tif.0.2008.10.29.01.55.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 01:55:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99352>

Hi,

I often feel tracking branches are useless to me, because there are remote
branches and I work on my private branch in most time.

   repos
     |
     |-- my               (private branch, do my dirty work)
     |-- master           (tracking branch)
     |-- origin/master    (remote branch)

To avoid conflict when execute `git pull` and make the history linear, I work
on branch "my" instead of "master". Here is my work flow:

1) use `git fetch` or `git remote update` to synchronize branch "origin/master"
with branch "master" in remote repository;
2) create a new private branch to polish my commits and rebase it against
"origin/master";
3) at last push this new branch to the remote repository or ask the upstream
developer to fetch it(no `git pull` because we want history as linear as possible).

I don't want to bother with the tracking branch "master", it's identical
with "origin/master".  Because `git checkout -b xxx <remote_branch>`
will create a tracking branch "xxx" by default, so my question is:
do most people feel tracking branches useful?


BTW: I feel the terminalogy "remote branch" is confused, because I must
synchronize it with `git fetch`. I feel it's better to call it "tracking
branch" // seems will lead to bigger confusion to experienced git users:-(
