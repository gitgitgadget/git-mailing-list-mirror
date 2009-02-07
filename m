From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: fix running mergetool in sub-directories
Date: Sat, 07 Feb 2009 13:48:55 -0800
Message-ID: <7v3aepuddk.fsf@gitster.siamese.dyndns.org>
References: <1233357611-31820-1-git-send-email-charles@hashpling.org>
 <1233357611-31820-2-git-send-email-charles@hashpling.org>
 <7v63jv0wn6.fsf@gitster.siamese.dyndns.org> <49877F68.30509@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas.floden@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv4N-0000OA-7X
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZBGVtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbZBGVtH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:49:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZBGVtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:49:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FF5B97FFA;
	Sat,  7 Feb 2009 16:49:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CF53997FF9; Sat,
  7 Feb 2009 16:48:57 -0500 (EST)
In-Reply-To: <49877F68.30509@hashpling.org> (Charles Bailey's message of
 "Mon, 02 Feb 2009 23:19:04 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21F15476-F561-11DD-A9D1-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108889>

Charles Bailey <charles@hashpling.org> writes:

> Junio C Hamano wrote:
>> 
>> I wonder if it would be cleaner to keep $prefix and instead cd_to_toplevel
>> at the beginning.
>> ...
> Possibly, and I certainly wouldn't object if mergetool moved to the
> latter mode of operation in the medium term.
>
> In general, though, mergetool is pretty happy running from the users
> directory and there may be cases in which users expect the merge tool to
> be running from the directory that they started in (saving extra files
> during the merge process?).

A very sensible consideration that I agree with.  I am happy that you
were the one who volunteered to take this script over.
