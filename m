From: "Imran M Yousuf" <imran@smartitengineering.com>
Subject: Re: [JGit Patch v2 5/7] Add script for adding second pack for test purpose
Date: Sat, 23 Aug 2008 11:21:51 +0600
Message-ID: <9e85b2570808222221k64b95557hc1e808a925ac5a56@mail.gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
	 <1219288394-1241-5-git-send-email-imyousuf@gmail.com>
	 <20080821151252.GS3483@spearce.org>
	 <9e85b2570808211952sa903434lacd575388ad2d2d8@mail.gmail.com>
	 <20080822160651.GI3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	robin.rosenberg@dewire.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 07:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWlaT-0003wc-85
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 07:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYHWFVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 01:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYHWFVx
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 01:21:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:6694 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYHWFVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 01:21:53 -0400
Received: by ey-out-2122.google.com with SMTP id 6so66964eyi.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 22:21:51 -0700 (PDT)
Received: by 10.210.28.6 with SMTP id b6mr2695621ebb.60.1219468911354;
        Fri, 22 Aug 2008 22:21:51 -0700 (PDT)
Received: by 10.210.86.13 with HTTP; Fri, 22 Aug 2008 22:21:51 -0700 (PDT)
In-Reply-To: <20080822160651.GI3483@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93421>

On Fri, Aug 22, 2008 at 10:06 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imran@smartitengineering.com> wrote:
>> On Thu, Aug 21, 2008 at 9:12 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > imyousuf@gmail.com wrote:
>> >> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>> >>
>> >> Forgot to add it last time and thus adding it before removing duplicate
>> >> resources.
>> >
>> > I would squash this to the one that copies the other resources.
>>
>> I would gladly make the changes (in this patch and the other ones) if
>> I am sure that this series does not break the build with Eclipse. I
>> would be extremely grateful if you would please confirm this to me.
>
> OK, so your series end result would be fine, if you squash this into
> it as well.  The "tst" variable is no longe rused in one location due
> to the introduction of JGitTestUtil, and you missed one location that
> needed to be converted from "tst" to JGitTestUtil.  Otherwise the end
> result looks good in Eclipse and in ./make_jgit.sh.

Thanks for the confirmation and additional change, for some reason it
was not failing thus I could not detect the case. I will now follow
the suggestions and will resubmit the patches on Mon/Tuesday.

- Imran

>
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
> index 310690a..270b90a 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
> @@ -143,7 +143,6 @@ public void run() {
>                                "pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
>                                "pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
>                };
> -               final File tst = new File("tst");
>                final File packDir = new File(db.getObjectsDirectory(), "pack");
>                for (int k = 0; k < packs.length; k++) {
>                        copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".pack"), new File(packDir,
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
> index c036e79..3d81bc4 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
> @@ -41,9 +41,11 @@
>  import java.io.File;
>  import java.io.IOException;
>
> +import org.spearce.jgit.util.JGitTestUtil;
> +
>  public class T0004_PackReader extends RepositoryTestCase {
>        private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
> -       private static final File TEST_PACK = new File(new File("tst"), PACK_NAME + ".pack");
> +       private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
>        private static final File TEST_IDX = new File(TEST_PACK.getParentFile(), PACK_NAME + ".idx");
>
>        public void test003_lookupCompressedObject() throws IOException {
>
>
> --
> Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
