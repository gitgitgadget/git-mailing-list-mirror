From: Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 1/2] strbuf: add tests
Date: Mon, 30 May 2016 15:42:20 +0200 (CEST)
Message-ID: <559442672.168369.1464615740454.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr> <alpine.DEB.2.20.1605301323310.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 30 15:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7NLN-0000IQ-QS
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 15:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbcE3Nex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 09:34:53 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:57005 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137AbcE3New (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 09:34:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8139D20AD;
	Mon, 30 May 2016 15:34:50 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SK1pH0CkO-xe; Mon, 30 May 2016 15:34:50 +0200 (CEST)
Received: from zm-int-mbx10.grenet.fr (zm-int-mbx10.grenet.fr [130.190.242.149])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 63ACD20AA;
	Mon, 30 May 2016 15:34:50 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1605301323310.4449@virtualbox>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: strbuf: add tests
Thread-Index: jGHaQ77G9UGUvzphfAfqnv45AWME8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295895>

Hi Johannes, 

I'm William's teammate on this feature. 

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi William,
> 
> On Mon, 30 May 2016, William Duclot wrote:
> 
> > Test the strbuf API. Being used throughout all Git the API could be
> > considered tested, but adding specific tests makes it easier to improve
> > and extend the API.
> > ---
> 
> The commit message makes sense. Please add your sign-off.
> 

We forgot to add the sign-off, we will fix that in the V2.

> >  Makefile               |  1 +
> >  t/helper/test-strbuf.c | 69
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  t/t0082-strbuf.sh      | 19 ++++++++++++++
> >  3 files changed, 89 insertions(+)
> >  create mode 100644 t/helper/test-strbuf.c
> >  create mode 100755 t/t0082-strbuf.sh
> > 
> > diff --git a/Makefile b/Makefile
> > index 3f03366..dc84f43 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -613,6 +613,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
> >  TEST_PROGRAMS_NEED_X += test-sha1
> >  TEST_PROGRAMS_NEED_X += test-sha1-array
> >  TEST_PROGRAMS_NEED_X += test-sigchain
> > +TEST_PROGRAMS_NEED_X += test-strbuf
> >  TEST_PROGRAMS_NEED_X += test-string-list
> >  TEST_PROGRAMS_NEED_X += test-submodule-config
> >  TEST_PROGRAMS_NEED_X += test-subprocess
> > diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
> > new file mode 100644
> > index 0000000..622f627
> > --- /dev/null
> > +++ b/t/helper/test-strbuf.c
> > @@ -0,0 +1,69 @@
> > +#include "git-compat-util.h"
> > +#include "strbuf.h"
> > +
> > +/*
> > + * Check behavior on usual use cases
> > + */
> > +int test_usual(struct strbuf *sb)
> 
> I have to admit that I would prefer a more concrete name. And since your
> other tests are more fine-grained, maybe this one could be split into
> multiple separate ones, too?
> 

We will rename this function.
We thought that one complete function would be convenient to test 
the usual API's behaviour. We are not sure how that change would be useful?

> > +{
> > +	size_t size, old_alloc;
> > +	char *res, *old_buf, *str_test = malloc(5*sizeof(char));
> 
> Our convention is to list the initialized variables first, the
> uninitialized ones after that, and for readability an empty line is
> recommended after the variable declaration block.

OK, seems more readable.

> > +	strbuf_grow(sb, 1);
> > +	strcpy(str_test, "test");
> > +	old_alloc = sb->alloc;
> > +	strbuf_grow(sb, 1000);
> > +	if (old_alloc == sb->alloc)
> > +		die("strbuf_grow does not realloc the buffer as expected");
> > +	old_buf = sb->buf;
> > +	res = strbuf_detach(sb, &size);
> > +	if (res != old_buf)
> > +		die("strbuf_detach does not return the expected buffer");
> > +	free(res);
> > +
> > +	strcpy(str_test, "test");
> > +	strbuf_attach(sb, (void *)str_test, strlen(str_test), sizeof(str_test));
> > +	res = strbuf_detach(sb, &size);
> > +	if (res != str_test)
> > +		die("strbuf_detach does not return the expected buffer");
> > +	free(res);
> > +	strbuf_release(sb);
> > +
> > +	return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	size_t size = 1;
> > +	struct strbuf sb;
> 
> The common theme in our source code seems to initialize using
> STRBUF_INIT... Let's use that paradigm here, too?

We will add a test to check that initializing with srtbuf_init(...) is the
same as initializing with STRBUF_INIT. 

> 
> > +	char str_test[5] = "test";
> > +	char str_foo[7] = "foo";
> > +
> > +	if (argc != 2)
> > +		usage("test-strbuf mode");
> 
> A nice and convenient way to do command-line parsing is to use the
> parse-options API, in this case with OPT_CMDMODE. This would also give us
> a chance to document the command modes in a nice and succinct way: as help
> strings.
> 

True, we're going to make that change.


> > +
> > +	if (!strcmp(argv[1], "basic_grow")) {
> > +		/*
> > +		 * Check if strbuf_grow(0) allocate a new NUL-terminated buffer
> 
> s/allocate/&s/
> 
> > +		 */
> > +		strbuf_init(&sb, 0);
> > +		strbuf_grow(&sb, 0);
> > +		if (sb.buf == strbuf_slopbuf)
> > +			die("strbuf_grow failed to alloc memory");
> > +		strbuf_release(&sb);
> > +		if (sb.buf != strbuf_slopbuf)
> > +			die("strbuf_release does not reinitialize the strbuf");
> > +	} else if (!strcmp(argv[1], "strbuf_check_behavior")) {
> > +		strbuf_init(&sb, 0);
> > +		return test_usual(&sb);
> > +	} else if (!strcmp(argv[1], "grow_overflow")) {
> > +		/*
> > +		 * size_t overflow: should die()
> > +		 */
> > +		strbuf_init(&sb, 1000);
> > +		strbuf_grow(&sb, maximum_unsigned_value_of_type((size_t)1));
> 
> A comment "If this does not die(), fall through to returning success, to
> indicate an error" might be nice here.

Agreed.

> > +	} else {
> > +		usage("test-strbuf mode");
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
> > new file mode 100755
> > index 0000000..0800d26
> > --- /dev/null
> > +++ b/t/t0082-strbuf.sh
> > @@ -0,0 +1,19 @@
> > +#!/bin/sh
> > +
> > +test_description="Test the strbuf API.
> > +"
> 
> This description does not need a new-line, and existing one-liner test
> descriptions seem not to be terminated by a period.

OK.

> The rest of this patch looks good.
> 
> Ciao,
> Johannes
> 

Thanks for the Review,
Simon Rabourg
