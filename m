From: Michael Hendricks <michael@ndrix.org>
Subject: Re: [PATCH] format-patch: add arbitrary email headers
Date: Thu, 26 Mar 2009 10:42:12 -0600
Message-ID: <20090326164212.GF29569@ginosko.ndrix.org>
References: <1237996712-61859-1-git-send-email-michael@ndrix.org>
 <7v3ad11kqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmsgU-0007Kk-Vm
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbZCZQm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755176AbZCZQm3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:42:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35824 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754564AbZCZQm2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 12:42:28 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id DE79C2FE579;
	Thu, 26 Mar 2009 12:42:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 26 Mar 2009 12:42:26 -0400
X-Sasl-enc: ZNXf7LLF+KuEkz3uXknCRlgNWxBu3pDRejLVs28KKeHJ 1238085746
Received: from ginosko.ndrix.org (unknown [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6BE99541A1;
	Thu, 26 Mar 2009 12:42:26 -0400 (EDT)
Received: by ginosko.ndrix.org (Postfix, from userid 501)
	id 4173DF8C5FE; Thu, 26 Mar 2009 10:42:12 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <7v3ad11kqh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114798>

On Wed, Mar 25, 2009 at 12:11:02PM -0700, Junio C Hamano wrote:
> Michael Hendricks <michael@ndrix.org> writes:
> 
> > format-patch supports the format.headers configuration for adding
> > arbitrary email headers to the patches it outputs.  This patch adds
> > support for a --header argument which makes the same feature available
> > from the command line.  This is useful when the content of custom
> > email headers must change from branch to branch.
> 
> How should this interact with the configuration variable?
> 
> Typically we allow command line options to override the matching config
> variable, so that people can say "here are the settings I ordinarily use"
> in the config file, and say "but I do not want the usual values to take
> effect for this particular invocation; please use these _instead_" with
> command line options.
> 
> Note that the above question is "how should this interact"; not "how does
> this interact".  I can see you chose to make this cumulative in your patch
> and the documentaiton.
> 
> I am asking if that is what the users want, overriding is preferred, or
> perhaps another option to clear extra headers (say, "--no-extra-headers")
> is necessary to allow both.

In all the cases where I use custom headers on patch emails, I want
the command line headers to be cumulative with the config headers.  I
only configure headers which are constant (such as "X-Project:
project-name").  The ones that vary have no reasonable default value
since they typically represent a bug tracking number or something
similar.

Perhaps --add-header is a better name for this argument.  That name at
least makes it clear that headers specified on the command line are
cumulative.  If someone has a use case for --no-extra-headers, they
can add it later and --add-header retains the same meaning.

Follow-up patch coming shortly.

-- 
Michael
