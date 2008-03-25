From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Mon, 24 Mar 2008 17:11:58 -0700
Message-ID: <7v1w5zslv5.fsf@gitster.siamese.dyndns.org>
References: <fs9f0o$jge$1@ger.gmane.org>
 <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 25 01:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdwma-0000cc-D2
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 01:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbYCYAMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 20:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYCYAMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 20:12:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbYCYAMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 20:12:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6239214D4;
	Mon, 24 Mar 2008 20:12:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BE52214D3; Mon, 24 Mar 2008 20:12:02 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
 (Julian Phillips's message of "Tue, 25 Mar 2008 00:01:53 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78133>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Tue, 25 Mar 2008, Michael Gebetsroither wrote:
>
>> hi,
>>
>> % git-add -f foo/.git/bar
>> fatal: unable to add foo/.git/bar to index
>
> Well, git won't allow .git as a element anywhere in the path, when we
> should only care about the _first_ one - and also, if you use
> --git-dir=banana then we still check for '.git' ... oops.

That's not how git-dir is supposed to used, so there is no oops.

Also it is false that we should only care about the first one.  Think
submodules.
