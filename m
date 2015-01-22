From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/5] So you dislike the sequence of system calls?
Date: Thu, 22 Jan 2015 15:11:32 -0800
Message-ID: <1421968297-25407-1-git-send-email-sbeller@google.com>
References: <54C0DDE7.8030708@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org, ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jan 23 00:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQui-0001Qd-12
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbbAVXLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:11:43 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33415 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbbAVXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:11:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id vy18so198840iec.5
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBVWZMke0JQbpJ+pAYQRGhP/mQmMQ2bdJ5t0b4KeTag=;
        b=LpIjTZUD358VpjkQYOxi8tzGc3hkwqDRLUI/6CIqz4v/KLMYmKNrHnGTukK4KiU3LW
         rQWQFzOS0PRcuvoRCYLl3yIKn/sen1m98mdMCbcalduqIhk1Jg5VsYBeGSTc2j4B+Xt2
         karsQfm4SgMK2nYTsTZ0orAC3njKD/WEAHQPtPlwI6EefI7D/Hye9/4gULNQ4P1sKpW0
         LCtZQ33m7oaN3CvaJIKbVmX9rDNQY8egzRYdXrVNAZJr9qGosAZiZJELU39vpzE6h3yI
         6HGS6rBfRZBfGmXg+tDp/rxVNwBipzGGQ0mZJmGVdWBK/RztDFAA19Nvqz/dBJXf5Bpn
         u06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBVWZMke0JQbpJ+pAYQRGhP/mQmMQ2bdJ5t0b4KeTag=;
        b=dhfL22OoWmdAf2j9ChvWNq/BQb55xzONHZbnkrYcR3uG5YrNYROikOyuiNZokuwwmS
         4hdYs5rJXMJeHlC9O7gD32DqQ94RRS9/UWkmz9WNPmM0QQ7utw3pdFItfL7DuItLT8gA
         0LVJjWdLIr2Jq6Y836V8xRjV6roCPFFABr+of4yJIZmdK1sGdSWuFKqbnORPi46olKzJ
         cO040nXp3WasmoXeazrOyon0E45jVsaPRcUk+DT153bnD12Yrv5cfjwVe7E+3JlGjuBd
         MT6oTEdvu+QQVehFF/8i62L14qtB9NTJVRnFuqE0T6tpJIMDCcLlkEtLkl/EnoT0J8cn
         QKyw==
X-Gm-Message-State: ALoCoQk0OdV6zAoekPb6Pl6SZDrHs4iUpodvTOdSenhWNWxBbpD0uWP9Baax2T5TC/yqh2Mnin/I
X-Received: by 10.42.88.9 with SMTP id a9mr6183334icm.34.1421968301042;
        Thu, 22 Jan 2015 15:11:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e0f4:42de:391f:3cc5])
        by mx.google.com with ESMTPSA id x3sm241399ioi.34.2015.01.22.15.11.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 15:11:40 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <54C0DDE7.8030708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262886>

This series goes on top of origin/sb/atomic-push-fix for now.

I am inclined to squash the first patch into the last commit of 
origin/sb/atomic-push-fix when rerolling that series as it just 
fixes the warning Ramsay pointed out. I'd also like to combine
this series with the origin/sb/atomic-push-fix in a reroll of
either series such that it becomes one larger series.

The patches 2,3,4 are just preparations (no change intended)
for the patch 5 which then corrects the sequence of system calls
such that we don't close and reopen the lock file.

(Background: Why am I spending time to fix that bug the way I do?)
I think writing out the sha1 early to the .lock file helps in
further patch series for cross repository atomic pushes, because
if we can split the transaction_commit into two parts, where the
latter part only has lock file pathes in memory, dealing with
cross repository ref updates becomes easy in such a way:
(compare discussion [RFC] Introducing different handling 
for small/large transactions)

        cat << EOF > stdin_pipe
        delete topic2 2345
        update master 4567 2378
        repository ../API-consumer # this switches to another repository
        delete topic2 3459
        update master 6787 9878
        EOF
        git update-ref --stdin <stdin_pipe

Internally update-ref would be easy to implement when all you 
have left are lock files you'd need to commit.

Any feedback welcome!

Thanks,
Stefan

Stefan Beller (5):
  fixup for "refs.c: enable large transactions"
  refs.c: remove unlock_ref from write_ref_sha1
  refs.c: move static functions to close and commit refs
  refs.c: remove committing the ref from write_ref_sha1
  refs.c: write values to lock files early for committing

 refs.c | 81 ++++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

-- 
2.2.1.62.g3f15098
