From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Fri, 13 Feb 2009 18:14:36 -0800
Message-ID: <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
References: <200902122303.37499.jnareb@gmail.com>
 <1234510803-23268-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200902130945.20601.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYA4j-00058r-L3
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbZBNCOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbZBNCOq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:14:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbZBNCOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:14:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D6B9B2B14D;
	Fri, 13 Feb 2009 21:14:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8A35E2B14C; Fri,
 13 Feb 2009 21:14:38 -0500 (EST)
In-Reply-To: <200902130945.20601.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 13 Feb 2009 09:45:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E6C97B0-FA3D-11DD-83FA-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109802>

Jakub Narebski <jnareb@gmail.com> writes:

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> Sounds good. I don't use gitweb as DirectoryIndex myself, but
> Acked-by: Jakub Narebski <jnareb@gmail.com>
>
>> +# Another issue with the script being the DirectoryIndex is that the resulting
>> +# $my_url data is not the full script URL: this is good, because we want
>> +# generated links to keep implying the script name if it wasn't explicitly
>> +# indicated in the URL we're handling, but it means that $my_url cannot be used
>> +# as base URL. Therefore, we have to build the base URL ourselves:
>> +our $base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};

Breaks t9500 with 

    [Sat Feb 14 02:12:59 2009] gitweb.perl: Use of uninitialized value in concatenation (.) or string at /pub/git/t/../gitweb/gitweb.perl line 45.

Please be more careful when giving an Ack, and more importantly please do
not send a patch that does not even pass the test suite by itself.
