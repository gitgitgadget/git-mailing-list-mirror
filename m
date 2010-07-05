From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fatal: internal error in diff-resolve-rename-copy
Date: Mon, 5 Jul 2010 20:20:18 +0200
Message-ID: <AANLkTimyZnvIs9XCwxKLxisum5KllXwrPygkCidC1CnH@mail.gmail.com>
References: <4C31CA75.9010709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 20:20:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVqHY-0003Vs-7k
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 20:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab0GESUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 14:20:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62227 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab0GESUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 14:20:20 -0400
Received: by wyf23 with SMTP id 23so2527357wyf.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sVPv7c2sgYZVDVqRU/mUVurInc0/dm6xIZ1vugknpso=;
        b=e8MkP1F7XHnHbLdX+wvXmuHNzrB2ErRrsLhA9QyfPArA2HJLNHozEYlistZBH5Cc0/
         oJFnlqkC3Qk6S57jj6muflEAstQMFJ18GFg/u022v8cUJZ5e5AttpXrLadmL5/sHDCCO
         HTw+1emZuKuXIBYmwwcEREWVOUSLpqTMrZ6A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NfvL2lgVL5x6qg4aMyhQB+VWFWkyfCaBxm2gKCgWNF97jtB4tmQarYgruKe0j49OW7
         WjU9a8a7wB3v13NmEg63jisVmWIRxbeD95ISrJgqFi31Zo4PI8TLyLIIffMQ16UJYASr
         LTeYqq3EqAPW8TKMwhDgSazD3SS5kxrMExkDw=
Received: by 10.213.5.6 with SMTP id 6mr2503986ebt.18.1278354019097; Mon, 05 
	Jul 2010 11:20:19 -0700 (PDT)
Received: by 10.213.112.208 with HTTP; Mon, 5 Jul 2010 11:20:18 -0700 (PDT)
In-Reply-To: <4C31CA75.9010709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150283>

On Mon, Jul 5, 2010 at 14:05, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> can someone help me with understanding or debugging the following? With
> "log -p --stat" I get that strange fatal error. (With GIT_FLUSH=0 it
> appears upfront.)
>
> Without "-p --stat" the log is displayed without a fatal error (same 3
> commits), but with "-p" or "--stat" (or both) it's fatal.

Could you run the case under valgrind? (I suspect a corruption of diff
data structures)
