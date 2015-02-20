From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 14:27:50 -0500
Message-ID: <00b701d04d43$514ddfb0$f3e99f10$@nexbridge.com>
References: <20150220065801.7CDC7140BE4@smtp.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Git Mailing List'" <git@vger.kernel.org>,
	"'Stephen Morton'" <stephen.c.morton@gmail.com>,
	"'Duy Nguyen'" <pclouds@gmail.com>,
	"'Joachim Schmitz'" <jojo@schmitz-digital.de>
To: "'Martin Fick'" <mfick@codeaurora.org>,
	"'David Turner'" <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 20:28:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOtFA-0008Ho-Kd
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 20:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbbBTT2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 14:28:03 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47470 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbbBTT2C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 14:28:02 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t1KJRqYB057683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Feb 2015 14:27:53 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <20150220065801.7CDC7140BE4@smtp.codeaurora.org>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIFAHiBvT022NtyWGyCa/+wtfpWPpyQgQfQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264180>

-----Original Message-----
On Feb 20, 2015 1:58AM Martin Fick wrote:
>On Feb 19, 2015 5:42 PM, David Turner <dturner@twopensource.com> wrote:
> > This one is not affected by how deep your repo's history is, or how 
> > wide your tree is, so should be quick.. 
>Good to hear that others are starting to experiment with solutions to this problem!  I hope to hear more updates on this.

<snip-snip>

Now that Jojo and I  have git 2.3.0 ported to the HP NonStop platform, there are some very large code bases out there that may start being managed using git. These will tend to initially shallow histories (100's not 1000's of commits, and fairly linear) but large source and binaries - I know of a few where just the distributed set of sources are above 1Gb and are unlikely to be managed in multiple repos despite my previous best efforts to change that. Fortunately, It is a relatively simple matter to profile the code on the platform for various operations so data on where to improve may be available - I hope. 

With that said, for NonStop file system tends to be heavier weight than on Linux (many more moving parts by virtue of the MPP nature of the OS and hardware). Packing up changes seems pretty good, but any operating involving creating a large number of small files does hurt a bunch.
