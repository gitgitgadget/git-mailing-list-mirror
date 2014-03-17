From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Mon, 17 Mar 2014 16:07:46 +0100
Message-ID: <53270FC2.2030701@alum.mit.edu>
References: <20140308183501.GH18371@serenity.lan> <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net> <8738ijzbue.fsf@thomasrast.ch> <20140316020018.GA20019@sigill.intra.peff.net> <7v1ty14z8x.fsf@alter.siamese.dyndns.org> <7vtxax2v1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 16:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPZ8x-0001A0-JT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 16:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705AbaCQPHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 11:07:54 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60767 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933411AbaCQPHx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 11:07:53 -0400
X-AuditID: 12074414-f79d96d000002d2b-3b-53270fc779c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C3.23.11563.7CF07235; Mon, 17 Mar 2014 11:07:51 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD44AD.dip0.t-ipconnect.de [79.221.68.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2HF7k2q013368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Mar 2014 11:07:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <7vtxax2v1q.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsUixO6iqHucXz3Y4OEWU4sPSz4yWXRd6Way
	aOi9wmwxcdpiZosb53exWvxo6WG2aJv5g8ni4DFJBw6P5Tf/MnmcffSA2eNZ7x5Gj4uXlD32
	vjrE5DHl3n9Wj8+b5DxuP9vGEsARxW2TlFhSFpyZnqdvl8CdseF6K1PBe9mKF51f2BsY/4l1
	MXJySAiYSPR1nmGEsMUkLtxbz9bFyMUhJHCZUWLvgudQznkmiWddV9lAqngFtCVOnbvPBGKz
	CKhKHF3dCxZnE9CVWNTTDBYXFQiWWH35AQtEvaDEyZlPwGwRATWJiW2HWECGMgv0MElM+36T
	GSQhLOAmcfPrIahtU5gkzjRNAZvKKWAmMfXiTfYuRg6g+8QlehqDQMLMAjoS7/oeMEPY8hLb
	385hnsAoOAvJvllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQT
	IyRyRHYwHjkpd4hRgINRiYf3BZt6sBBrYllxZe4hRkkOJiVR3n4+oBBfUn5KZUZicUZ8UWlO
	avEhRgkOZiUR3ku8QDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQne
	LSBDBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFRHF8MjGOQFA/Q3hUg7bzFBYm5
	QFGI1lOMuhwbtq1pZBJiycvPS5US520AKRIAKcoozYNbAUuTrxjFgT4W5l0CUsUDTLFwk14B
	LWECWrJouhrIkpJEhJRUA2NUrLSPdFx49vxHgZeXmB6t2PqsOG3foxfsNxlFF9Y9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244253>

On 03/17/2014 07:33 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Would it make sense to go one step further to introduce two macros
>> to make this kind of screw-up less likely?
>> ...
>> After letting my eyes coast over hits from "git grep memmove", there
>> do seem to be some places that these would help readability, but not
>> very many.
> 
> I see quite a many hits that follow this pattern
> 
> 	memmove(array + pos, array + pos + 1, sizeof(*array) * (nr - pos))
> 
> to make a single slot in a middle of array available, which would be
> good candidates to use MOVE_DOWN().  Just to show a few:
> 
> builtin/mv.c:226:	memmove(source + i, source + i + 1,
> builtin/mv.c-227-		(argc - i) * sizeof(char *));
> builtin/mv.c:228:	memmove(destination + i,
> builtin/mv.c-229-		destination + i + 1,
> builtin/mv.c-230-		(argc - i) * sizeof(char *));
> cache-tree.c:92:	memmove(it->down + pos + 1,
> cache-tree.c-93-		it->down + pos,
> cache-tree.c-94-		sizeof(down) * (it->subtree_nr - pos - 1));
> 
> 
> Perhaps something like this patch to start off; I am not sure
> MOVE_DOWN_BOUNDED is needed, though.
> 
>  cache.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index b66cb49..b2615ab 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -455,6 +455,39 @@ extern int daemonize(void);
>  		} \
>  	} while (0)
>  
> +/*
> + * With an array "array" that currently holds "nr" elements, move
> + * elements at "at" and later down by "count" elements to make room to
> + * add in new elements.  The caller is responsible for making sure
> + * that the array has enough room to hold "nr" + "count" slots.
> + */
> +#define MOVE_DOWN(array, nr, at, count)			\
> +	memmove((array) + (at) + (count),		\
> +		(array) + (at),				\
> +		sizeof((array)[0]) * ((nr) - (at)))
> +
> +/*
> + * With an array "array" that has enough memory to hold "alloc"
> + * elements allocated and currently holds "nr" elements, move elements
> + * at "at" and later down by "count" elements to make room to add in
> + * new elements.
> + */
> +#define MOVE_DOWN_BOUNDED(array, nr, at, count, alloc)		     \
> +	do {							     \
> +		if ((alloc) <= (nr) + (count))			     \
> +			BUG("MOVE_DOWN beyond the end of an array"); \
> +		MOVE_DOWN((array), (nr), (at), (count));	     \
> +	} while (0)
> +
> +/*
> + * With an array "array" that curently holds "nr" elements, move elements
> + * at "at" + "count" and later down by "count" elements, removing the
> + * elements between "at" and "at" + "count".
> + */
> +#define MOVE_UP(array, nr, at, count)				\
> +	memmove((array) + (at), (array) + (at) + (count),	\
> +		sizeof((array)[0]) * ((nr) - ((at) + (count))))
> +
>  /* Initialize and use the cache information */
>  extern int read_index(struct index_state *);
>  extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);

I had recently been thinking along the same lines.  In many of the
potential callers that I noticed, ALLOC_GROW() was used immediately
before making space in the array for a new element.  So I suggest
something more like

+#define MOVE_DOWN(array, nr, at, count)	\
+	memmove((array) + (at) + (count),		\
+		(array) + (at),				\
+		sizeof((array)[0]) * ((nr) - (at)))
+#define ALLOC_INSERT_GAP(array, nr, at, count, alloc)		     \
+	do {							     \
+		ALLOC_GROW((array), (nr) + (count), (alloc));        \
+		MOVE_DOWN((array), (nr), (at), (count));	     \
+	} while (0)

Also, count==1 is so frequent that this special case might deserve its
own macro pair.

I'm not inspired by these macro names, though.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
