From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC 2/7] git-submodule: Extract absolute_url & move
 absolute url logic to module_clone
Date: Fri, 11 Apr 2008 14:56:23 -0700
Message-ID: <7vzls0qcmw.fsf@gitster.siamese.dyndns.org>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 23:57:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkRFL-0000ZD-UM
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 23:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbYDKV4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 17:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbYDKV4j
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 17:56:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418AbYDKV4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 17:56:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B6C7A1F6B;
	Fri, 11 Apr 2008 17:56:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 370F21F6A; Fri, 11 Apr 2008 17:56:31 -0400 (EDT)
In-Reply-To: <1207842625-9210-5-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Thu, 10 Apr 2008 23:50:19 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79300>

Ping Yin <pkufranky@gmail.com> writes:

> This behaviour change breaks t7400 which uses relative url './.subrepo'.
> However, this test originally doesn't mean to test relative url, so fix
> the url as '.subrepo'.

Hmmm.  Doesn't "foo" generally mean the same thing as "./foo" in the sense
both are relative to the current directory?
