From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Mon, 11 Jan 2016 11:50:23 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601111122410.2964@virtualbox>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de> <eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
 <CAPig+cRjy+xU7dZEbVfqD3LQ8YdzS2gWKL4tufSHfGSaUU-M1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 11:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIa3d-00066u-A0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 11:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759179AbcAKKuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 05:50:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:57067 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759126AbcAKKug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 05:50:36 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MOTRh-1aF1oV2QRp-005mOE; Mon, 11 Jan 2016 11:50:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cRjy+xU7dZEbVfqD3LQ8YdzS2gWKL4tufSHfGSaUU-M1Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:aJoDEgoQDOCdfeaebCTk9mXxMX4PVMW17836m/lXsbhlI4odCak
 FD5mZ+o1D7V53eskKruNRccROWWbFa4tgimZgnIjtGGyzxU2OAlKQksty83CPonWArEiiF1
 ZYkl9Q4iCzjh7meMI17+zSq+owIK0B/u7XCmDGaGUUVuaFWKAR8uUwKV579bCraDY1b2avg
 UaNOnzEGWSSTWeR/cuT3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GOAvGriR+P4=:/ic8TjifUCD5TvBKzu+XSJ
 Lh+KYMFnHn3mw2g6R1sY43gzg+7YaxGOWLagJ6RQjuAcDP+5UfEp7kgqA/4Er8dkU1v35xQDv
 pDhfzSGDvJZwYc9h1jN4LkTkVav6MeRKVjQFC9t27sQlWfFATAo2gE4G8tLmqivsBFSaBLyWC
 0ugUx2EZ85O0Y4LL2KN5WRfaKvRaJR9WNypLPddpq/7dNW3RjpxrrGbnhC41SNmvhahTCwxfv
 ErFqAsTGY0hfgjRTRlt0rHOx4DpP6MvYqfGdtTCjSRqN5oWBWrpTgz/1k/l6qBrden9hjwFes
 oKXNJ3658izMKFwlNE6xqHrhMg+pp6gEMgB6eMqmLkNDEkqSu3gB8A28warquHCtzkJ25qVJU
 oW94bn7V4zNvY7hdGuRq/aG/O0U49CIQEvUjOBtbr0wMwTXPuoU9R0pz5aX6I8UHdAkYVydR4
 GGVN0AeSeexQgmDXczTKSj+jrCxMMzkFG/sB3vlRH5fwiJsg3mTtooPZVXU5KnGmbnNWe2Iml
 1eP+zIw/ZpyT0Gle9Vli7Q6S0tb7m+GLZGODF+32iBLM7ca+Atv6hU+JFXXaFcDwYElbhim/p
 E5C6RVyTO4k+G4v+7LjWfFlK08Ab0gwaZgJgQ+0DyOJkG5GJg7V8kIEMGDPykBGdcr4s+/9vx
 qMekOxrmFuiH4SKB4UMA791ig6W8R8RXmUZr3f7jLjVc09ZkM9Fe/KP63qGxofJHrBUkSiL+4
 To1AHRPAvhuSL9gQ4NplNFlN+oDlILGnZ5t7PbQlTXy1d2mxuoHGDr9n5zT9eyY5kcXFZX9P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283643>

Hi Eric,

On Sat, 9 Jan 2016, Eric Sunshine wrote:

> On Fri, Jan 8, 2016 at 11:21 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Unfortunately, some libgen implementations yield outcomes different from
> > what Git expects. For example, mingw-w64-crt provides a basename()
> > function, that shortens `path0/` to `path`!
> >
> > So let's verify that the basename() and dirname() functions we use conform
> > to what Git expects.
> >
> > Derived-from-code-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/test-path-utils.c b/test-path-utils.c
> > @@ -39,6 +39,168 @@ static void normalize_argv_string(const char **var, const char *input)
> > +struct test_data {
> > +       char *from;  /* input:  transform from this ... */
> > +       char *to;    /* output: ... to this.            */
> 
> Can these be 'const'? If I'm reading the code correctly, I don't think
> these values ever get passed directly to functions expecting non-const
> strings.

This, and ...

> > +};
> > +
> > +static int test_function(struct test_data *data, char *(*func)(char *input),
> > +       const char *funcname)
> > +{
> > +       int failed = 0, i;
> > +       static char buffer[1024];
> 
> Why is this 'static'? It is never accessed outside of this scope.

... this, and ...

> > +       char *to;
> > +
> > +       for (i = 0; data[i].to; i++) {
> > +               if (!data[i].from)
> > +                       to = func(NULL);
> > +               else {
> > +                       strcpy(buffer, data[i].from);
> > +                       to = func(buffer);
> > +               }
> > +               if (strcmp(to, data[i].to)) {
> > +                       error("FAIL: %s(%s) => '%s' != '%s'\n",
> > +                               funcname, data[i].from, to, data[i].to);
> > +                       failed++;
> 
> Since 'failed' is only ever used as a boolean, it might be clearer to say:
> 
>     failed = 1;

... this and ...

> > +               }
> > +       }
> > +       return !!failed;
> 
> And then simply:
> 
>     return failed;
> 
> > +}
> > +
> > +static struct test_data basename_data[] = {
> > +       /* --- POSIX type paths --- */
> > +       { NULL,              "."    },
> 
> NULL is tested here.
> 
> > +       { "",                "."    },
> > +       { ".",               "."    },
> > [...]
> > +#endif
> > +       { NULL,              "."    },
> 
> And also here. Is that intentional?

... this are all valid concerns that I now addressed locally, so they will
be fixed in the next iteration.

Thanks,
Dscho
