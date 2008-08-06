From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git diff-tree --stdin doesn't accept two trees
Date: Wed, 06 Aug 2008 08:31:13 -0700
Message-ID: <7vbq06rwhq.fsf@gitster.siamese.dyndns.org>
References: <20080805164839.GA3934@diana.vm.bytemark.co.uk>
 <7vwsivusy2.fsf@gitster.siamese.dyndns.org>
 <20080806115358.GD18336@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQl7z-0003ZQ-M2
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759047AbYHFPjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759921AbYHFPjI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:39:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759927AbYHFPjC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 11:39:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D62BA4D3F5;
	Wed,  6 Aug 2008 11:31:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A7FDA4D3F1; Wed,  6 Aug 2008 11:31:16 -0400 (EDT)
In-Reply-To: <20080806115358.GD18336@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Wed, 6 Aug 2008 13:53:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7C597EA-63CC-11DD-9C7C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91522>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

>> The feature of --stdin to take a commit and its parents on one line =
was
>> broken before that to support the common
>>
>>         rev-list --parents $commits... -- $paths... |
>>                 diff-tree --stdin -v -p
>>
>> usage pattern by Porcelains.  For diff-tree to talk sensibly about
>> commits, it needs to see commits, not just trees.
>
> But is there any fundamental reason why it couldn't accept tree-ishes
> as well?

The -v option given to diff-tree is the key.  Without it, it could take
trees.
