From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Addition of source and javadoc plugins to maven script
Date: Wed, 1 Apr 2009 14:48:19 +0300
Message-ID: <85647ef50904010448j688b1c7agd01e7dfef107b36d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 13:56:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loz3l-0005jv-KA
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 13:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763667AbZDALyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 07:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763660AbZDALx7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 07:53:59 -0400
Received: from mail-fx0-f170.google.com ([209.85.220.170]:53657 "EHLO
	mail-fx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763626AbZDALx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 07:53:57 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2009 07:53:57 EDT
Received: by fxm18 with SMTP id 18so677fxm.7
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=GjfNCtZ2/sbES0VStiETZNAa3sGA+TVfw1T2l+PQZZc=;
        b=NWqWWc7KvK0GKkADcjXc32Cl8h9465813JEPuT842nnduL/3FpIHv1zwrU8KOJi4vt
         WEIbp/Bg1buBbn4zfjRDtwXJwvBwROmxriMFy2+SDCbnnUzK40ErXf7WQWhoFzhRM6B8
         Im1LKEw2kdoMXpdm2CR3OnwzF02T4I0fiREJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=a09U6QK7mmB5qdu1FVm7p4hcPlZhFPVz49eRHAZkeIxse6774aXS6OqXBMBBhda3Tk
         mLHdKOESRSXXDBCqqoxI7Q5M09FmLHeNnLiigHANw7kaOt6SDHkEKfwAhx17T5Rpc4Sd
         tvYSfn6WV51fNKeh4cyFIGNk1+inj5PBLqFGk=
Received: by 10.204.53.143 with SMTP id m15mr2758708bkg.119.1238586499930; 
	Wed, 01 Apr 2009 04:48:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115373>

When JGIT jar is bundled with projects, it often needed
to inspect JGIT sources in order to look for documentation
and implementation. The sources are also very useful during
debugging. The patch adds source plugin that builds source jar,
so the matching version of the source.jar could be easily
bundled. The javadoc plugin generates ready to use archive with
javadoc.
---
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
