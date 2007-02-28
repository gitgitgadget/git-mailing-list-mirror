From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 10:40:15 -0600
Message-ID: <17893.45167.334963.409569@lisa.zopyra.com>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	<20070228035713.GC5597@spearce.org>
	<20070228044719.GA6068@spearce.org>
	<17893.40847.313519.283218@lisa.zopyra.com>
	<17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
	<17893.43522.511785.121778@lisa.zopyra.com>
	<17893.44181.129918.669187@lisa.zopyra.com>
	<20070228163256.GD5479@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRqp-0003Qx-Hm
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbXB1QkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbXB1QkV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:40:21 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60636 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbXB1QkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:40:21 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SGeHN25705;
	Wed, 28 Feb 2007 10:40:17 -0600
In-Reply-To: <20070228163256.GD5479@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40960>

On Wednesday, February 28, 2007 at 11:32:56 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> >The code has this:
>> >
>> >        unsigned long from = obj[0].offset + obj[0].hdr_size;
>> >        unsigned long len = obj[1].offset - from;
>> >
>> >by "offset", do you want obj[0].offset and obj[1].offset?
>> >
>> >How do I get the size of the packfile?  Is it obj->size?
>
>I meant something like this:
>...

% cd ~/devel/project
% git-fsck --full
% cd -
% git clone --bare ~/devel/project
[...]
fatal: cannot pread pack file: Success from=39395, packfile size=2
fatal: index-pack died with error code 128

And, again, this works fine on my non-mounted file system:

% cd ~/test
% git clone --bare ~/devel/project
Initialized empty Git repository in /home/blear/test/project/
remote: Generating pack...
remote: Done counting 4594 objects.
remote: Deltifying 4594 objects.
remote:  100% (4594/4594) done
Indexing 4594 objects.
remote: Total 4594 (delta 2210), reused 4591 (delta 2209)
 100% (4594/4594) done
Resolving 2210 deltas.
 100% (2210/2210) done


Bill
