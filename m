From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] git-completion.zsh: do not clobber complete()
Date: Wed, 30 Apr 2014 05:02:31 -0500
Message-ID: <5360ca37ef906_47db12fd31035@nysa.notmuch>
References: <1392413040-28436-1-git-send-email-lodato@google.com>
 <5360911d8fb6e_597a125b30828@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Lodato <lodato@google.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Mark Lodato <lodato@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 12:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfRVq-0005Xt-1I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 12:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396AbaD3KNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 06:13:09 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:56156 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaD3KNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 06:13:08 -0400
Received: by mail-yh0-f54.google.com with SMTP id b6so1383600yha.41
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=1WCyoGbwfVsxSDWGOqiBkQHqwnsSRKh6BViLSJGx00w=;
        b=NTOG3ocIotpQtIU1olC4a82Uk217p5X6ElFIb4ENuqL+d+4spKG1OXUgBXgEe7y3Wh
         w5D31p/okuSa3WUfAa+tGmAxcgiyKFnWadEXq8as5uMzyU3AMTAQl4E+Au4G8AH8lQtf
         DpbV4QRCrHs5bHkQxTNMrlLVApcC9QTwF/DHLXvwrlMCjNRbXxvV3BXRvrHdYkI05Twp
         3YOpCX1p5Jgh3o0Is7NuujfiS9bzVQ4N+CjVjuvEU8/1sOlI/2nKBYJLQeVQM1RWRSWz
         5k+vrTlPXnO3jnTOnH3YfKgzYjq2AwDfGcpA86tn9/zcysogeV79DQ9eY7yOmEwbWU0i
         6ckA==
X-Received: by 10.236.94.103 with SMTP id m67mr4497931yhf.104.1398852787856;
        Wed, 30 Apr 2014 03:13:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n5sm42022937yhn.43.2014.04.30.03.13.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 03:13:06 -0700 (PDT)
In-Reply-To: <5360911d8fb6e_597a125b30828@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247697>

Felipe Contreras wrote:
> Mark Lodato wrote:
> > Previously, git-completion.zsh redefined complete() to make
> > __git_complete() a no-op. This broke zsh's built-in bash completion
> > compatibility layer (bashcompinit), which defines its own complete().
> 
> How exactly? I'm testing this and I don't see any problems. I run
> 'type -f _complete' and I get bashcompinit's complete, and the internal
> _complete() function is used only by the _git completion.

Ah, it's complete(), not _complete(). I see the problem and I'll propose
a similar patch.

-- 
Felipe Contreras
