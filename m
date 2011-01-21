From: David Brown <davidb@codeaurora.org>
Subject: Re: impact on git of changing linux o/s system-date frequently
Date: Thu, 20 Jan 2011 23:13:15 -0800
Message-ID: <8yaaaiuhgqc.fsf@huya.qualcomm.com>
References: <ihaie3$63g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 08:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgBBT-0001rI-Oa
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 08:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab1AUHNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 02:13:16 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:27616 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab1AUHNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 02:13:15 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6232"; a="71347009"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostssh01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2011 23:13:15 -0800
Received: from localhost.qualcomm.com ([127.0.0.1] helo=huya.qualcomm.com)
	by mostssh01.qualcomm.com with esmtp (Exim 4.71)
	(envelope-from <davidb@codeaurora.org>)
	id 1PgBB1-0001Qr-1r; Thu, 20 Jan 2011 23:12:55 -0800
X-Hashcash: 1:20:110121:git@vger.kernel.org::Z9m4HWP/BR5nrpDP:000000000000000000000000000000000000000000AQ/d
X-Hashcash: 1:20:110121:neal@rsss.com::QvvpSJPQs5lh55IS:0000Bj26
In-Reply-To: <ihaie3$63g$1@dough.gmane.org> (Neal Kreitzinger's message of
	"Thu, 20 Jan 2011 18:01:10 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165357>

On Thu, Jan 20 2011, Neal Kreitzinger wrote:

> What are the implications of linux o/s system-date changes on git?
>
> We plan on having test VM's on which the linux o/s system-date (linux "date" 
> command) is changed several times to test time lapse scenarios, e.g. go 
> forward 30 days in the future.  We use git to pull updates from the 
> development machine to mirror repos and cloned repos on the test VM, and to 
> create test areas (local repos) on the test VM.  We do not use git-push or 
> git-commit on the test VM at this time.

Without making commits on the machine, there won't be any history being
created with misordered dates, so there shouldn't be any issues there.

The index should also be pretty resiliant to time warping as well, and
if you aren't modifying any of the git managed files, I don't think you
can provoke anything.

If you're doing edits of files, there's a slight possibility the edited
version could end up with the same ctime/mtime as the cache in the
index, and git would miss the change.  Again, it doesn't sound like you
are doing this.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
