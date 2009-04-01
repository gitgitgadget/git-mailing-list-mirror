From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH v2] Addition of source and javadoc plugins to maven 
	script
Date: Wed, 1 Apr 2009 14:50:58 +0300
Message-ID: <85647ef50904010450ief9e3b2lf4245bac86bd4c6f@mail.gmail.com>
References: <85647ef50904010448j688b1c7agd01e7dfef107b36d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 13:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loz5A-00069z-US
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 13:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761423AbZDAL4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 07:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757082AbZDAL4g
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 07:56:36 -0400
Received: from mail-fx0-f166.google.com ([209.85.220.166]:52118 "EHLO
	mail-fx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062AbZDAL4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 07:56:35 -0400
Received: by fxm10 with SMTP id 10so3131143fxm.18
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=6HyzAkS4sEYTUczkJDWM+75uYJD8Ab6UFeCimZ006AM=;
        b=YAup4+dpQl0GeYr62PLAb0Xy0sU7r2XfnhdtXHCE6nkSUM+huoWutX/Iw/VzLmN6q7
         F/ogmILjtgsM0Hv+pYDAjlgids7aP8yTJJHzetfEHZnEaGlX2v1gvbpG2GiDAXMydDQR
         LxyXbTFBtSu9SGbwNFn0VF9nVkan9JcWrjNaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=n9UY3x982T1kYkxxO/YTjyLToAGLMtxB96wxmcqzgomCPSRjY6fOp7+VG3ODUmwJhg
         jU9pAmBc4EDErdP2H4kgoV3LVBsA/KicTcfXssYSZe+QANEY8nSLqNWBX+XEVraTwdqt
         x+Pn/1yIDo0q37KGw0Ij47E5SY7jfU9lMqUBI=
Received: by 10.204.63.74 with SMTP id a10mr2757671bki.189.1238586658383; Wed, 
	01 Apr 2009 04:50:58 -0700 (PDT)
In-Reply-To: <85647ef50904010448j688b1c7agd01e7dfef107b36d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115374>

When JGIT jar is bundled with projects, it often needed
to inspect JGIT sources in order to look for documentation
and implementation. The sources are also very useful during
debugging. The patch adds source plugin that builds source jar,
so the matching version of the source.jar could be easily
bundled. The javadoc plugin generates ready to use archive with
javadoc.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
Forgot Signed-off-by in the previous version.

 jgit-maven/jgit/pom.xml |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index c370783..75c4b75 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -169,6 +169,26 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
                     </includes>
                 </configuration>
            </plugin>
+           <plugin>
+               <artifactId>maven-source-plugin</artifactId>
+               <executions>
+                   <execution>
+                       <goals>
+                           <goal>jar</goal>
+                       </goals>
+                   </execution>
+               </executions>
+            </plugin>
+            <plugin>
+                <artifactId>maven-javadoc-plugin</artifactId>
+                <executions>
+                    <execution>
+                        <goals>
+                            <goal>jar</goal>
+                        </goals>
+                    </execution>
+                </executions>
+            </plugin>
         </plugins>
     </build>
     <dependencies>
-- 
1.6.0.2.1172.ga5ed0
