From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 13:34:54 -0500
Message-ID: <37CD335A-00A7-4074-BD39-4FCDEEB3D083@apple.com>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com> <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com> <20101129171211.GL8037@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 19:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN8ZP-0007gs-OJ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 19:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab0K2SfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 13:35:01 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:54298 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab0K2Se5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 13:34:57 -0500
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out3.apple.com (Postfix) with ESMTP id 3BE04BB9B6CD;
	Mon, 29 Nov 2010 10:34:57 -0800 (PST)
X-AuditID: 11807136-b7cf5ae0000051a4-95-4cf3f2507fb3
Received: from [17.153.103.154] (Unknown_Domain [17.153.103.154])
	by relay15.apple.com (Apple SCV relay) with SMTP id 95.2F.20900.052F3FC4; Mon, 29 Nov 2010 10:34:57 -0800 (PST)
In-Reply-To: <20101129171211.GL8037@burratino>
X-Mailer: Apple Mail (2.1082)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162412>


On Nov 29, 2010, at 12:12, Jonathan Nieder wrote:

> Thiago Farina wrote:
>> On Mon, Nov 29, 2010 at 2:57 PM, Jeremy Huddleston <jeremyhu@apple.com> wrote:
> 
>>> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
>>> Reviewed-by: Matt Wright <mww@apple.com>
> 
> I like the idea, but could you add a short commit message
> explaining the existing behavior and what improvement this makes?

Hopefully what I resent is sufficient for explaining the changes.

>> Why not #if defined(__APPLE__), like above?

Originally for style.  I like #ifdef better than #if defined(), but I changed it for you in the resend.

> More importantly, please search for #ifdef in existing code to get
> some examples of how we like to do platform-specific things.

Yeah, I see some:
#ifdef _WIN32

which is why I used __APPLE__.  Do you have a better suggestion?

> The section "2) #ifdefs are ugly" of
> linux-2.6/Documentation/SubmittingPatches explains the rationale.

I agree, but I don't really see a way around it here since this API is specific to OS X.
