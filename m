From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 15:28:12 +0530
Message-ID: <CALkWK0=WCsXErHft9RbDOeehon7E2oCj5-YT6Ph+8bLFW-5JaQ@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 10:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHtK1-0001Qr-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 10:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712Ab3CSJ6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 05:58:35 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:41156 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab3CSJ6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 05:58:33 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so231839iag.17
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=OeQTmLJeDipddkvtpmsrSEscvq92xdZcit9cV1QlTq8=;
        b=WbLhZLkP6xy+RRrqRRqTKYmgBrtDGmX8z+D0lOFMNDFyaiBoCxmEHMqWjFmGKr96Gb
         ZKUmS3RRJ+bcHqdn0y6Hy5dl9nUooVq+1TIHUgKPf2tT6y4PykqItRLmSBHLDXqTOjjc
         ox+o8e0idLtItP++pM82Ey4JqgwM+EV/ArNe/svvDcNh+GTHp/RfC9UU7TvDYgFbjERF
         ec+XCfo2iaoCAHqE+V+X/RbHRLY1a0ezoRynfSOywXxByGaoKCNg18dgBmdOjHg+W1pW
         jFeAh932Kz18bEMcIi4kkccbiIaayq8PRFLZPSqO823da8Y/ykX5+W5yU3ENwZL15nax
         QIhQ==
X-Received: by 10.42.204.79 with SMTP id fl15mr10487623icb.57.1363687112588;
 Tue, 19 Mar 2013 02:58:32 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 19 Mar 2013 02:58:12 -0700 (PDT)
In-Reply-To: <20130318170804.GA15924@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218491>

Jeff King wrote:
> On Mon, Mar 18, 2013 at 10:28:59PM +0530, Ramkumar Ramachandra wrote:
>> Is there a reason for the remote not being optional, or are we just
>> waiting for a patch?  The only problem I can foresee is very minor:
>> there is a ref with the same name as a remote; in this case, we'd have
>> to specify both the remote and the ref.
>
> I think the ambiguity is a little more complex than that, because we
> cannot enumerate the universe of all remotes. Keep in mind that we can
> take either a configured remote or a URL (or ssh host). So what does:
>
>   git push foo:bar
>
> mean? Is it pushing "refs/heads/foo" to "refs/heads/bar" on "origin"? Or
> is it using the default refspecs to push to the "bar" repo on the host
> "foo" over ssh?

Wait, why does git-push support pushing to a URL directly?  Shouldn't
the user be required to create a new remote out of the URL and push to
that?  What happens to upstream branches if we directly push to a URL?
