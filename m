From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 14:16:35 +0100
Message-ID: <200707091416.39949.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org> <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net> <20070709115029.GD16032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 15:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7t6g-0005g0-I7
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 15:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbXGINQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 09:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXGINQs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 09:16:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:39653 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbXGINQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 09:16:47 -0400
Received: by mu-out-0910.google.com with SMTP id i10so868528mue
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 06:16:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Dko0Kg89+p3UIU4z4BxEJ2AOeI7754lOX7jtmgpYkhTLpiGxj6ffP+jETgdUYWu9A/b5tnAFFocQ3bWOhkOXCmfYecvUuIxTpTeZZU4q9mHIJQvg2fbhTWs+nw0pR8EAxPeD1vgilFi9pO7HNVLixw/qAQJ5FKVCaJjGh/qwSKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tzomxZRzwWGjnZbf0n0edBShyZwd4yZveSpafw/5kH9POhoxPE9WMnJUPx/fbXbFSHFLAlmRi3b5vwv9hqBTk4nwzDvsJTMFbFUbQmUucmYykE2Mfpr9R4DxC/GMrzmk0xPTfZbWNuT7kEUiMKC4I4EgXrOJ+KUhF+zb/QVD+mc=
Received: by 10.82.105.13 with SMTP id d13mr8165269buc.1183987005170;
        Mon, 09 Jul 2007 06:16:45 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm31635882ika.2007.07.09.06.16.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jul 2007 06:16:44 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070709115029.GD16032@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51990>

On Monday 2007 July 09, Theodore Tso wrote:
> On Sun, Jul 08, 2007 at 10:39:41PM -0700, Junio C Hamano wrote:
> > Are _identifiers with leading underscore Kosher thing to do, I
> > wonder...  We do have ones with trailing ones (mostly qsort
> > functions) and I think they are done that way for the sake of
> > standards conformance.
>
> _[a-z]* is kosher for file scopes or function scoping:

Perhaps I'm reading it wrong but:

"All identifiers beginning with an underscore are reserved for ordinary 
identifiers (functions, variables, typedefs, enumeration constants) with file 
scope."

Doesn't agree with what you've said.  I think that you _can_ use _[a-z]* for 
labels or structure members - however, not within file or function scope.

However, the rule of thumb I've always used is "don't start identifiers with 
underscore".  I can't think of a situation that would mean you have to use an 
underscore to start an identifier - so why get into detailed worries about 
where it's allowed and where it isn't.  Just don't use it.  The document you 
linked to gives exactly this advice:

"Don't give anything a name with a leading underscore."

> P.S.  Note that the Linux kernel does not worry about such rules; in
> particular, _[a-z]* is very commonly used at the global scope level,
> without any problems.  It doesn't have to be as portable as git
> probably needs to be, however.

The kernel doesn't use any standard library so there is nothing for it to 
conflict with.  I don't think it's that the kernel doesn't worry about those 
rules, it's that those rules don't apply (just as they don't for glibc).  The 
underscore rules aren't a limitation of the language, they are a limitation 
imposed by the standard library.  



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
