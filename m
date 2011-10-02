From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Re: Bug?: 'git log --find-copies' doesn't match 'git log --follow <rev> -- path/to/file'
Date: Sun, 2 Oct 2011 17:10:26 +0200
Message-ID: <67B22035-4B90-4A68-8960-DDB58F640CD9@inf.fu-berlin.de>
References: <DBC73B3F-2703-4651-AADA-233A9CC38AFD@inf.fu-berlin.de> <20110930213841.GA9384@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 02 17:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RANgZ-0008Ts-4X
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 17:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab1JBPKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 11:10:30 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47913 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752725Ab1JBPK3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 11:10:29 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1RANgR-0002Ea-Ue>; Sun, 02 Oct 2011 17:10:27 +0200
Received: from dslb-088-075-073-091.pools.arcor-ip.net ([88.75.73.91] helo=[192.168.2.104])
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1RANgR-0006M5-Qh>; Sun, 02 Oct 2011 17:10:27 +0200
In-Reply-To: <20110930213841.GA9384@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 88.75.73.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182603>


Am 30.09.2011 um 23:38 schrieb Jeff King:

> On Fri, Sep 30, 2011 at 05:32:38PM +0200, Alexander Pepper wrote:
> 
>> So git log with copy and rename detection on (--find-copies) tells me,
>> that the file StopClusterException.java is copied to
>> ClusterOperation.java. But If I ask git log for that specific file
>> with --follow git claims a copy from Immutable.java to
>> ClusterOperation.java!
> 
> I think that --follow uses --find-copies-harder. Did you try:
> 
>  git log --numstat --find-copies-harder dd4e90f9
> 
> ? Does it find Immutable.java as the source?
> 
> -Peff


Using 'git log --numstat --find-copies-harder dd4e90f9' yields "immutable.java" as you expected:

$ git log --numstat --find-copies-harder dd4e90f9
[...]
6       10      src/java/voldemort/annotations/concurrency/Immutable.java => contrib/ec2-testing/src/java/voldemort/utils/ClusterOperation.java

So is there a way to tell --follow to only use --find-copies instead of --find-copies harder? And what is the advantage of using "--find-copies-harder" over "--find-copies"?

Greetings from Berlin
Alex

-- 
Alexander Pepper
pepper@inf.fu-berlin.de
