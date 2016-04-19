From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 5/6] fetch: pass refspec to http server
Date: Tue, 19 Apr 2016 17:25:46 -0400
Organization: Twitter
Message-ID: <1461101146.5540.120.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-6-git-send-email-dturner@twopensource.com>
	 <CAPig+cSxkuWB5qqVY3-m9ESmmHMKwXM+qtbRsZ1j1osjp2i3HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:25:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asd9d-0001wN-6u
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbcDSVZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:25:49 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35104 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbcDSVZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:25:48 -0400
Received: by mail-qg0-f47.google.com with SMTP id f74so15865833qge.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=q+SmCMkjqrOro04Md0lvfos1A1uaBQvkMSkeT7BduYE=;
        b=EDHmVIfM+X8moAdIQtNDMuffxVd4nVTLbv7WLVy6WknCYdUpEIcZu7z7OgW1xBzwOQ
         zWyUrOiBL6x2ZTfTFfSgQLVXhL9bhIxw3GreW6PVO6B1p/bR3HXGh5Ik5Fhg3qEp6YYA
         jLn1gpJRCbIHZAsEwJ3gWIfaoOQJYrveD8FjOAyNOzqWRrggtqTJP3hPCRXBNY0FWh5p
         K1w8Sz0z1sGKl4R/v6tbOL6PUjqJLTVWtP13XcIFIhNMWwhwUb81tqv4CeTUIHH/1pLT
         yghprMv3N1Ab48QSP7iQguZil9JqfHvF1UDmfxvzgmJnMSdoYN9hCbcbSpsbFR/8ggDL
         gBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=q+SmCMkjqrOro04Md0lvfos1A1uaBQvkMSkeT7BduYE=;
        b=gbYf9QrrWT8qOfg+qyplTnQgMsFg8WJuRJnUnRw//fNn79LNvEEqwlLZ+VubJUx6f3
         88RNs8+AzMqi1EwD7NsUrKeZgdO4Liue04OVnodLvNlnID1gmohiowxgA3SXiafmfa20
         eAGtrG+QWm7Eh1zAc9cU5VBn8lSoAxaub8hunHu6TGHJ9uG0Tj50Us2GQ6fgBzeiytb1
         bGFydNRAgcdqYuEFTx7UPDfgmJkNFesoA+xj2OlK45xBXWYAHHJVr/3mYHwKoEcpVitN
         Po6/jGezVHwkB8jkfZdRAGcztVujYY7I/vIR7jFznZicFyLeYMvP2HNMT6Km4y+ByrYr
         HT8w==
X-Gm-Message-State: AOPr4FXszec4Mwl5t2x8OKY1WyxB+FARTZhfsfl97S0nayzQQeep7OofcfOLbgadLxlS1w==
X-Received: by 10.140.174.86 with SMTP id u83mr6552427qhu.35.1461101147504;
        Tue, 19 Apr 2016 14:25:47 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f83sm29852879qkb.25.2016.04.19.14.25.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 14:25:46 -0700 (PDT)
In-Reply-To: <CAPig+cSxkuWB5qqVY3-m9ESmmHMKwXM+qtbRsZ1j1osjp2i3HQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291930>

On Sat, 2016-04-16 at 22:33 -0400, Eric Sunshine wrote:
> On Fri, Apr 15, 2016 at 3:19 PM, David Turner <
> dturner@twopensource.com> wrote:
> > When fetching over http, send the requested refspec to the server.
> > The server will then only send refs matching that refspec.  It is
> > permitted for old servers to ignore that parameter, and the client
> > will automatically handle this.
> > 
> > When the server has many refs, and the client only wants a few,
> > this
> > can save bandwidth and reduce fetch latency.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > @@ -302,9 +302,27 @@ static struct ref *get_ref_map(struct
> > transport *transport,
> > -       remote_refs = transport_get_remote_refs(transport, NULL,
> > 0);
> > +       qualified_refspecs = xcalloc(refspec_count,
> > sizeof(*qualified_refspecs));
> > +       for (i = 0; i < refspec_count; i++) {
> > +               if (starts_with(refspecs[i].src, "refs/")) {
> > +                       qualified_refspecs[i].src =
> > xstrdup(refspecs[i].src);
> > +               } else {
> > +                       struct strbuf buf = STRBUF_INIT;
> > +                       strbuf_addf(&buf, "refs/heads/%s",
> > refspecs[i].src);
> > +                       qualified_refspecs[i].src =
> > strbuf_detach(&buf, NULL);
> 
> Alternately, replace these three lines with:
> 
>     qualified_refspecs[i].src = xstrfmt("refs/heads/%s",
> refspecs[i].src);
> 
> and drop the braces.

Yep, good point.

> > +               }
> > +       }
> > +
> > +       remote_refs = transport_get_remote_refs(transport,
> > qualified_refspecs,
> > +                                               refspec_count);
> > +
> > +       for (i = 0; i < refspec_count; i++) {
> > +               free(qualified_refspecs[i].src);
> > +       }
> > +       free(qualified_refspecs);
> > diff --git a/t/t5552-http-fetch-branch.sh b/t/t5552-http-fetch
> > -branch.sh
> > @@ -0,0 +1,42 @@
> > +test_expect_success 'make some more commits' '
> > +       (
> > +               cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +               test_commit 2 &&
> > +               git checkout -b another_branch &&
> > +               test_commit 3
> 
> Broken &&-chain.

Thanks.

> > +               git checkout -b a_third_branch &&
> > +               test_commit 4
> > +       )
> > +'
> > +
> > +test_expect_success 'fetch with refspec only fetches requested
> > branch' '
> > +       test_when_finished "rm trace" &&
> > +       (
> > +               cd clone &&
> > +               GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch
> > origin another_branch &&
> > +               ! grep "refs/heads/master" ../trace
> > +       )
> > +'
> 
> This could be done without the subshell, perhaps?
> 
>     GIT_TRACE_PACKET=blah git -C clone fetch ...


Will fix these, thanks.
