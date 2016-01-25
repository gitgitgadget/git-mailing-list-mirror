From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Mon, 25 Jan 2016 23:41:40 +0100
Message-ID: <20160125224140.GN7100@hank>
References: <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
 <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
 <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
 <20160122055255.GA14657@sigill.intra.peff.net>
 <20160122060720.GA15681@sigill.intra.peff.net>
 <20160124143403.GL7100@hank>
 <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
 <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
 <20160125144250.GM7100@hank>
 <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:41:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNpp1-0005LL-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 23:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbcAYWlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2016 17:41:16 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36870 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbcAYWlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 17:41:13 -0500
Received: by mail-wm0-f50.google.com with SMTP id n5so103550098wmn.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hDgUAvt/JiaKhTEGnjUA6m/4RGdCzbpmF/PfFVbDSLE=;
        b=ehQk9smvbfRsTzkHXW689cnOGh+8oCYvbpl2zqc+BPqM9uf5F5LkZLWlkh1Vi5IpkR
         fPfHpmOOIyo3U1oPeSqtuwcoICaGEY64/fyWmyCOrJOP1HC2C5iIp0c0ka5PhDuVyYyT
         cyUaBCUfDabi7glpePzF+2fJp+C5rrQr4Rfqz2tYACN5J3LZ8lLZr/vRDA6T2E1mxGLx
         hXRi8ZuHDv5suhWV1bqh6vfG4gZ+YRtmdwen7z5xOhFQWozC3h7uk73AEEMBcTB2TnqF
         H8R894rYZWaq24bj8zHzfdqiA8AcR7LqDUCy6IROYk1LPxDONRk1i6hukzEFU7NJU4WK
         w6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hDgUAvt/JiaKhTEGnjUA6m/4RGdCzbpmF/PfFVbDSLE=;
        b=e2arb9Sr8z2/CYVN3Awjk/E0NIm/c4MhVYKq0jh1u94SyiXNSFZg6fEmzAQFTcaNxI
         EOf8W3gW0cpT6wY3rKi+8SQbHpsdjHiOaK4fL3z/HiRp6doWcV24m27P8Hp5cpt3ag9j
         NVQsjY+h+qD4B2IklFq9n+eOHj62QT0s8FphcL4b50tfpWS4Bzjb9l8sC3zQ8FDwoh2O
         lXLUxRmM2kNMRQL6DIgty7l7vPdFcYYkfO/+PWUyBDflGVI7WxYIgC+dBBUhZYtkenrZ
         mUDfngnaMT1WeDLxeDE29Gr3ma9XjF1TD88P4cocRPuzJpgQX+/38AimN99G8AYAhXlR
         Kh3w==
X-Gm-Message-State: AG10YORet2lfwrFdqFmYRw7KHx+Q9s/yiR7ykFmTa3J0ta1ojAx6yfUyZXvsQSraO9x+gQ==
X-Received: by 10.194.23.70 with SMTP id k6mr19240829wjf.54.1453761672405;
        Mon, 25 Jan 2016 14:41:12 -0800 (PST)
Received: from localhost (host146-106-dynamic.20-79-r.retail.telecomitalia.it. [79.20.106.146])
        by smtp.gmail.com with ESMTPSA id 79sm103616wmo.7.2016.01.25.14.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 14:41:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284764>

On 01/25, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > On 01/24, Junio C Hamano wrote:
> >> To put it differently, if a blob stored at path has CRLF line
> >> endings and .gitattributes is changed after the fact to say that i=
t
> >> must have LF line endings, we should treat it as a broken transito=
ry
> >> state.
> >
> > Right, I wasn't considering this as a broken state, because t0025 u=
ses
> > just this to transition between the states.
> >
> >> There may have to be a way to "fix" an already "wrong" blob
> >> in the index that is milder than "rm --cached && add .", but I do
> >> not think write_entry(), which is shared by all the normal codepat=
hs
> >> that writes out to the working tree, is the best place to do so, i=
f
> >> doing so forces the contents of the paths to be always re-checked,
> >> just in case the user is in such a broken transitory state.
> >
> > Maybe I'm misunderstanding something, but the contents of the paths
> > are only re-checked if we are in such a broken transition state, an=
d
>
> What I do not understand here is how the added check ensures that
> "only if in such a broken transition state".  would_convert_to_git()
> does not take the contents but is called only with the pathname to
> key into the attributes, so in a typical cross platform project
> where all the source files are "text" and the repository can set
> core.eol to adjust the end of line convention for its working tree,
> the added check has no way to differentiate the paths that are
> recorded with CRLF line endings in the object database by mistake,
> i.e. the ones in the broken transitory state, and all the other
> paths that are following the "text" and storing their blobs with LF
> line endings.  The added check would trigger "is it racy" check to
> re-reads the contents that we have written out from the working tree
> for the paths with "wrong" blobs, but how would it avoid doing so
> for the paths whose blobs are already stored correctly?
>
> The new code affects not just "reset --hard", but everybody who
> writes out from the object database to the working tree and records
> that these paths are checked out in the index.  How does the new
> code avoid destroying the performance for all paths?

I misunderstood the way would_convert_to_git() works, I should have
actually read the code, instead of just relying on my test, which was
even wrong.  Sorry about the confusion, my patch does indeed hurt
the performance.

> > the file stored in git has crlf line endings, and thus would be
> > normalized.  In this case we currently re-check the contents of tha=
t
> > file anyway, at least when the file and the index have the same mti=
me,
> > and we actually show the correct output.
>
> The right way to at that "correct output", I think, is that it
> happens to be shown that way by accident.  It is questionable that
> it is correct to report that such a path is modified.  Immediately
> after you check out a path to the working tree out of the index, via
> "reset --hard" and "checkout $path", by definition it ought to be
> the same between the working tree file and the index.
>
> Unless it is in this transititory broken state, that is.
>
> The "by accident" happens only because racy-git avoidance is being
> implemented in one particular way.  Is about protecting people from
> making changes to the working tree files immediately after their
> previous contents are registered to the index (and the index files
> written to the disk), and immediately after we write things out of
> the index and by definition the result and the indexed blob ought to
> match there is no reason to re-read and recheck unless the working
> tree files are further edited.
>
> The current way the racy-git avoidance works by re-reading and
> re-checking the contents when the timestamps match is merely one
> possible implementation, and that is the only thing that produces
> your "correct" output most of the time in this test.  We could have
> waited after writing the index time for a second before giving the
> control back to the user instead, which would have also allowed us
> to implement the racy-git avoidance, and in that alternate world,
> all these transitory broken paths would have been correctly reported
> as unmodified.
>
> IOW, I would think the test in question is insisting a single
> outcome for an operation whose result is undefined, and it is
> harmful to twist the system by pessimizing the common cases just
> to cater to this transititory broken state.
>
> I am not saying that we shouldn't have support for users to fix
> their repository and get out of this transititory broken state.  A
> recent work by Torsten B=F6gershausen to have ls-files report the end
> of line convention used in the blob in the index and the settings
> that affect conversion for each path (among other things) is a step
> in the right direction.  With a support like that, those who noticed
> that they by mistake added CRLF files to the index as-is when they
> wanted their project to be cross platform can recover from it by
> setting necessary attributes (i.e. mark them as "text") and then
> find paths that are broken out of "ls-files --eol" output to see
> which ones are not using lf end-of-line in the index.
>
> I do not think there is a canned command to help dealing with these
> broken paths right now.  You would have to check them out of the
> index (you would get a CRLF file in the working tree in the example
> we are discussing), fix the line endings (you would run dos2unix on
> it in this example, as you would want "text=3Dtrue" attribute) and
> "git add" them to recover manually, but I can imagine that Torsten's
> work can be extended to do all of these, without molesting the
> working tree files, with minimum work by the end user.  That is:
>
>  * Reuse Torsten's "ls-files --eol" code to find paths that record
>    the blob in the index that does not follow the eol convention
>    specified for the path;
>
>  * For each of these index entries, run convert_to_working_tree() on
>    the indexed contents, and then on the result of it, run
>    convert_to_git().  The result is the blob that the index ought to
>    have had, if it were to be consistent with the attribute
>    settings.  So add that to the index.
>
>  * Write the index out.
>
>  * Tell the user to commit or commit it automatically with a canned
>    log message "fix broken encoding" or something.

Thanks for the thorough explanation, and the patch in the next email,
I'll have a look at that tomorrow.

--
Thomas
