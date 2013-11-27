From: "Philip Oakley" <philipoakley@iee.org>
Subject: Pack transfer negotiation to tree and blob level?
Date: Wed, 27 Nov 2013 22:52:14 -0000
Organization: OPDS
Message-ID: <1E0A3B7F917445C7A968C81C35892FD4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 27 23:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlnxE-0004la-SL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 23:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163Ab3K0Wv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 17:51:28 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:14488 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754595Ab3K0WvY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 17:51:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnEZAOh2llJZ8YjW/2dsb2JhbABZgnIIAgtjiGCoWIcpBQECAYEhF3RpAQGBHwEBFAETAQEuHgEBLAIIAgEkOQEEGgYHHQoRAgECAwGFOAcBghEjn3iHBZkLjiuDfoETA4kKhhKbC4MpPIEt
X-IPAS-Result: AnEZAOh2llJZ8YjW/2dsb2JhbABZgnIIAgtjiGCoWIcpBQECAYEhF3RpAQGBHwEBFAETAQEuHgEBLAIIAgEkOQEEGgYHHQoRAgECAwGFOAcBghEjn3iHBZkLjiuDfoETA4kKhhKbC4MpPIEt
X-IronPort-AV: E=Sophos;i="4.93,785,1378854000"; 
   d="scan'208";a="429367142"
Received: from host-89-241-136-214.as13285.net (HELO PhilipOakley) ([89.241.136.214])
  by out1.ip04ir2.opaltelecom.net with SMTP; 27 Nov 2013 22:51:22 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238469>

In the pack transfer protocol 
(Documentation\technical\pack-protocol.txt) the negotiation for refs is 
discussed, but its unclear to me if the negotiation explicitly navigates 
down into the trees and blobs of each commit that need to go into the 
pack.

>From one perspective I can see that, in the main, it's only commit 
objects that are being negotiated, and the DAG is used to imply which 
commit objects are to be sent between the wants and haves end points, 
without need to descend into their trees and blobs. The tags and the 
objects they point to are explicitly given so are negotiated easily.

The other view is that the negotiation should be listing every object of 
any type between the wants and haves as part of the negotiation. I just 
couldn't tell from the docs which assumption is appropriate. Is there 
any extra clarifications on this?

I ask as I was cogitating on options for a 'narrow' clone  (to 
complement shallow clones ;-) that could, say, in some way limit the 
size of blobs downloaded, or the number of tree levels downloaded, or 
even path limiting.

Philip Oakley 
