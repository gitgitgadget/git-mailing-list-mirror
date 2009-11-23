From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 19:29:24 +0100
Message-ID: <46a038f90911231029k4da4f37ai44d1b7a7aeefd52e@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
	 <200911231845.04325.trast@student.ethz.ch>
	 <4B0AD02E.1040408@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCdfI-0006WM-6f
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbZKWS3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbZKWS3T
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:29:19 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49790 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbZKWS3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 13:29:18 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so2134520ewy.21
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 10:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8sQc006H+fiOE9EffUbGtXo6xEN8HNPrrhuo92sQSis=;
        b=KutouSUUTlhwPJKHKW7o/KJA6qCczP9cYqiXbRBCc5+WHdtwk/QsEmm++Wy20X0v+V
         g0/vkHbpbGCm+MdVO93ZoJ+LOhbWcrbpWnFdZ7Kpi1e1Vu6b2VXYQgFvePixXlQBwki5
         8hSlaTx4hwVY+SJiMEi8tqN9uQKbEamUuKcq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RKGlUXx9hiKWZzaLfzEpzDUK7WOUGRsqqn6H1fitbO3RK4c3lTV6+2AzqoCXu7/yjf
         ZiHMmS9qYEVM1Ees7tLlwWxMnNtJ7sMw3D9Pke6kkxOc243rEFJMSsXSdVN/UPgH9uKe
         4dka0PVMrY3o/5E4Up3oMDFwbbBh5QQOrVyp8=
Received: by 10.213.23.76 with SMTP id q12mr3903511ebb.83.1259000964795; Mon, 
	23 Nov 2009 10:29:24 -0800 (PST)
In-Reply-To: <4B0AD02E.1040408@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133522>

On Mon, Nov 23, 2009 at 7:10 PM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
> I can't simply tunnel the file name as byte array to the
> invoked Git command - I simply don't know how to transform the characters of
> the file name to a representation the Git command line client will
> understand[2].

Ouch - so git is respecting whatever name the user and/or OS have
picked, but Java wants to canonicalize it,  and whatever scheme it
uses does not match OSX? That must hurt Java usage on OSX a lot. Sure
they have a workaround...?

Suggestions:

1 - Configure Java to canonicalize in the same style as OSX. Actually,
OSX's canonicalization is somewhat arbitrary so I think it exposes a
call to canonicalize a string "the right way".

2 - Many git calls accept filenames via STDIN - Java will surely write
binary there...

3 - xargs with its -z parameter can complement #2

hth,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
