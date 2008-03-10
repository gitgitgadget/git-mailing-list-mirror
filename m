From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 14:37:40 -0700
Message-ID: <7vk5kai7kr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site>
 <200803102232.13727.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org, gitster@poxbox.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYphe-0001yT-7S
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 22:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbYCJVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 17:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYCJVh4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 17:37:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbYCJVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 17:37:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02D291FEA;
	Mon, 10 Mar 2008 17:37:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1FC6D1FE8; Mon, 10 Mar 2008 17:37:41 -0400 (EDT)
In-Reply-To: <200803102232.13727.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Mon, 10 Mar 2008 22:32:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76758>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Monday 10 March 2008 21:42, Johannes Schindelin wrote:
>> For some reason, the construct
>>
>> 	sh -c "$0 \"$@\"" <editor> <file>
>>
>> does not pick up quotes in <editor> as expected.  So replace $0 with
>> <editor>.
>
> No surprise. It must be
>
> 	sh -c '"$0" "$@"' <editor> <file>
>
> Note the extra quotes around $0.

... assuming that there is no dq, $var_reference and other nastiness in
<editor> ;-)
