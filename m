From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-help: add "web_or_man" and "web_or_info" config vars.
Date: Tue, 11 Dec 2007 21:35:39 -0800
Message-ID: <7v1w9sbhlg.fsf@gitster.siamese.dyndns.org>
References: <20071212063325.92cd29a8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2KGw-0001U9-If
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 06:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757220AbXLLFf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 00:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757198AbXLLFf6
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 00:35:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109AbXLLFf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 00:35:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1DFF5CDB;
	Wed, 12 Dec 2007 00:35:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E1FB25CDA;
	Wed, 12 Dec 2007 00:35:48 -0500 (EST)
In-Reply-To: <20071212063325.92cd29a8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 12 Dec 2007 06:33:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67997>

I personally feel this is going a bit overboard.  We'd be better off
doing something like this:

 - add 'help.external' configuration variable, that allows the user to
   set any external program;

 - spawn the external program when "git help <cmd>" is given, with <cmd>
   as the parameter;

 - add an option to 'git config' to dump various paths configured in the
   git program, such as manual page path, info page path and such, so
   that the external program can learn where things are.

The second point above means that translating "cat-file" to
"git-cat-file.html" becomes the responsibility for the external
program.
