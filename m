From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Wed, 23 Sep 2009 23:16:02 +0200
Message-ID: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
Cc: Jason van Zyl <jvanzyl@sonatype.com>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCJ-0004af-8f
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZIWVPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZIWVPq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:15:46 -0400
Received: from n6.bullet.re3.yahoo.com ([68.142.237.91]:45289 "HELO
	n6.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752592AbZIWVPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:15:45 -0400
Received: from [68.142.237.90] by n6.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:15:48 -0000
Received: from [66.196.97.144] by t6.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:15:48 -0000
Received: from [127.0.0.1] by omp202.mail.re3.yahoo.com with NNFMP; 23 Sep 2009 21:15:48 -0000
X-Yahoo-Newman-Id: 634420.26006.bm@omp202.mail.re3.yahoo.com
Received: (qmail 22196 invoked from network); 23 Sep 2009 21:15:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
  b=dWKl5cc/+MSJADl2qApAPMgBmXEj1G8L6EK5DMV+rs6PD2HEE6R4V2ji1VUvyGck+kHDeJ4CmKEkKymzWrsgRZaZIzpEH3/CFYGYJs8/LRyz+qcSWhTCPTOyw5cAp9IvDMD2OP1WKvzfnXcwU4ehed5qRZZ6nSbdOdVMAuFemwM=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:15:48 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: b_2VNb4VM1nXMYXAeoHjsWj6rOz5eXW7MnwZQmk9HZ2t3IRZ_PFPBcUjyCUU4G9OO0gtsugaassCvuhshIOaqo1oqAwzXRdCSHBsrTWk1LMr31hHq_LfsqehTTElx4xltWdb97bheKbY0akGyEVonqiKeHnEwmqx.WDaHuS9Hs0CsFWGOxnoYUCy7dfasEyp1ODefznKD1hTLoyrJiOPXtAOsa2YJ5BCAA7G1Ddy5e_BtURdeVXKRgRoK.fqqDVtMOzGfOYzN_DG520lnThVaKaxAhXqAoCUZYlDpWJyMhjKzuxjm_kUKvb6NxRBm6vO6YZ.i7GhoN_aBU_IY8Xe8hL0zQvi8KSfW.Kr910-
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129000>

From: Jason van Zyl <jvanzyl@sonatype.com>

---
 .gitignore                    |    1 +
 org.spearce.jgit.pgm/pom.xml  |   59 ++++++++++
 org.spearce.jgit.test/pom.xml |   30 +++++
 org.spearce.jgit/pom.xml      |   35 ++++++
 pom.xml                       |  258 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 383 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/pom.xml
 create mode 100644 org.spearce.jgit.test/pom.xml
 create mode 100644 org.spearce.jgit/pom.xml
 create mode 100644 pom.xml

diff --git a/.gitignore b/.gitignore
index 5219cbc..37ca28d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 /jgit
 /jgit.jar
 /jgit_src.zip
+target
 /jgit_docs.zip
diff --git a/org.spearce.jgit.pgm/pom.xml b/org.spearce.jgit.pgm/pom.xml
new file mode 100644
index 0000000..9501cb5
--- /dev/null
+++ b/org.spearce.jgit.pgm/pom.xml
@@ -0,0 +1,59 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+  <modelVersion>4.0.0</modelVersion>
+  <parent>
+    <groupId>org.spearce</groupId>
+    <artifactId>jgit-parent</artifactId>
+    <version>0.5.0-SNAPSHOT</version>  
+  </parent>
+  <artifactId>org.spearce.jgit.pgm</artifactId>
+  <name>JGit :: Pgm</name>
+  <dependencies>
+        <dependency>
+            <groupId>org.spearce</groupId>
+            <artifactId>org.spearce.jgit</artifactId>
+            <version>${project.version}</version>
+        </dependency>    
+        <dependency>
+            <groupId>args4j</groupId>
+            <artifactId>args4j</artifactId>
+        </dependency>
+  </dependencies>
+  <build>
+    <sourceDirectory>src</sourceDirectory>
+    <resources>
+      <resource>
+        <directory>src</directory>
+        <includes>
+          <include>**/services/**</include>
+        </includes>
+      </resource>
+    </resources>
+    <plugins>
+      <plugin>
+        <groupId>org.apache.maven.plugins</groupId>
+        <artifactId>maven-shade-plugin</artifactId>
+        <version>1.2</version>
+        <executions>
+          <execution>
+            <phase>package</phase>
+            <goals>
+              <goal>shade</goal>
+            </goals>
+            <configuration>
+              <finalName>jgit-cli</finalName>
+              <createDependencyReducedPom>false</createDependencyReducedPom>
+              <transformers>
+                <transformer implementation="org.apache.maven.plugins.shade.resource.ServicesResourceTransformer"/>              
+                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
+                  <mainClass>org.spearce.jgit.pgm.Main</mainClass>
+                </transformer>
+              </transformers>
+            </configuration>
+          </execution>
+        </executions>
+      </plugin>
+    </plugins>      
+  </build>
+</project>
diff --git a/org.spearce.jgit.test/pom.xml b/org.spearce.jgit.test/pom.xml
new file mode 100644
index 0000000..db1fc46
--- /dev/null
+++ b/org.spearce.jgit.test/pom.xml
@@ -0,0 +1,30 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+  <modelVersion>4.0.0</modelVersion>
+  <parent>
+    <groupId>org.spearce</groupId>
+    <artifactId>jgit-parent</artifactId>
+    <version>0.5.0-SNAPSHOT</version>  
+  </parent>
+  <artifactId>org.spearce.jgit.test</artifactId>
+  <name>JGit :: Test</name>
+  <dependencies>
+        <dependency>
+            <groupId>org.spearce</groupId>
+            <artifactId>org.spearce.jgit</artifactId>
+        </dependency>    
+    <dependency>
+      <groupId>com.jcraft</groupId>
+      <artifactId>jsch</artifactId>
+    </dependency>    
+  </dependencies>
+  <build>
+        <testResources>
+            <testResource>
+                <directory>tst-rsrc/</directory>
+            </testResource>
+        </testResources>
+        <testSourceDirectory>tst/</testSourceDirectory>
+  </build>
+</project>
diff --git a/org.spearce.jgit/pom.xml b/org.spearce.jgit/pom.xml
new file mode 100644
index 0000000..2510ff7
--- /dev/null
+++ b/org.spearce.jgit/pom.xml
@@ -0,0 +1,35 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+  <modelVersion>4.0.0</modelVersion>
+  <parent>
+    <groupId>org.spearce</groupId>
+    <artifactId>jgit-parent</artifactId>
+    <version>0.5.0-SNAPSHOT</version>  
+  </parent>
+  <artifactId>org.spearce.jgit</artifactId>
+  <name>JGit :: Core</name>
+  <dependencies>
+    <dependency>
+      <groupId>com.jcraft</groupId>
+      <artifactId>jsch</artifactId>
+    </dependency>    
+  </dependencies>
+  <build>
+    <sourceDirectory>src</sourceDirectory>    
+    <plugins>
+            <plugin>
+                <groupId>org.apache.maven.plugins</groupId>
+                <artifactId>maven-surefire-plugin</artifactId>
+                <version>2.4.2</version>
+                <configuration>
+                    <includes>
+                        <include>**/*Test.java</include>
+                        <include>**/*TestCase.java</include>
+                        <include>**/T000*.java</include>
+                    </includes>
+                </configuration>
+           </plugin>            
+    </plugins>
+  </build>
+</project>
diff --git a/pom.xml b/pom.xml
new file mode 100644
index 0000000..7d52ba2
--- /dev/null
+++ b/pom.xml
@@ -0,0 +1,258 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!--
+All rights reserved.
+Redistribution and use in source and binary forms, with or
+without modification, are permitted provided that the following
+conditions are met:
+
+Redistributions of source code must retain the above copyright
+notice, this list of conditions and the following disclaimer.
+
+Redistributions in binary form must reproduce the above
+copyright notice, this list of conditions and the following
+disclaimer in the documentation and/or other materials provided
+with the distribution.
+
+Neither the name of the Git Development Community nor the
+names of its contributors may be used to endorse or promote
+products derived from this software without specific prior
+written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+-->
+<project xmlns="http://maven.apache.org/POM/4.0.0"
+        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+    <modelVersion>4.0.0</modelVersion>
+    <groupId>org.spearce</groupId>
+    <artifactId>jgit-parent</artifactId>
+    <packaging>pom</packaging>
+    <version>0.5.0-SNAPSHOT</version>
+    <name>JGit :: Parent</name>
+    <url>http://repo.or.cz/w/egit.git</url>
+    <mailingLists>
+        <mailingList>
+            <name>GIT Mailing List</name>
+            <post>git@vger.kernel.org</post>
+            <archive>http://marc.info/?l=git</archive>
+        </mailingList>
+    </mailingLists>
+    <description>Pure Java implementation of Git</description>
+    <developers>
+        <developer>
+            <name>Shawn O. Pearce</name>
+            <email>spearce@spearce.org</email>
+            <roles>
+                <role>Maintainer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Robin Rosenberg</name>
+            <email>robin.rosenberg@dewire.com</email>
+            <roles>
+                <role>Maintainer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Dave Watson</name>
+            <email>dwatson@mimvista.com</email>
+            <roles>
+                <role>Developer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Roger C. Soares</name>
+            <email>rogersoares@intelinet.com.br</email>
+            <roles>
+                <role>Developer</role>
+            </roles>
+	</developer>
+	<developer>
+            <name>Marek Zawirski</name>
+            <email>marek.zawirski@gmail.com</email>
+            <roles>
+                <role>Developer</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Charles O'Farrell</name>
+            <email>charleso@charleso.org</email>
+            <roles>
+                <role>Contributor</role>
+            </roles>
+        </developer>
+        <developer>
+            <name>Imran M Yousuf</name>
+            <email>imyousuf@smartitengineering.com</email>
+            <organization>Smart IT Engineering</organization>
+            <roles>
+                <role>Contributor</role>
+            </roles>
+        </developer>
+    </developers>
+    <licenses>
+        <license>
+            <name>3-clause (new-style) BSD license.</name>
+            <comments>
+                All rights reserved.
+                Redistribution and use in source and binary forms, with or
+                without modification, are permitted provided that the following
+                conditions are met:
+
+                Redistributions of source code must retain the above copyright
+                notice, this list of conditions and the following disclaimer.
+
+                Redistributions in binary form must reproduce the above
+                copyright notice, this list of conditions and the following
+                disclaimer in the documentation and/or other materials provided
+                with the distribution.
+
+                Neither the name of the Git Development Community nor the
+                names of its contributors may be used to endorse or promote
+                products derived from this software without specific prior
+                written permission.
+
+                THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+                CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+                INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+                OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+                ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+                CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+                SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+                NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+                LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+                CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+                STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+                ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+                ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+            </comments>
+        </license>
+    </licenses>
+    <build>
+        <plugins>
+            <plugin>
+                <groupId>org.apache.maven.plugins</groupId>
+                <artifactId>maven-compiler-plugin</artifactId>
+                <version>2.0.1</version>
+                <configuration>
+                    <source>1.5</source>
+                    <target>1.5</target>
+                    <encoding>UTF-8</encoding>
+                </configuration>
+            </plugin>
+        </plugins>
+    </build>
+    <dependencies>
+        <dependency>
+            <groupId>junit</groupId>
+            <artifactId>junit</artifactId>
+            <version>3.8.1</version>
+            <scope>test</scope>
+        </dependency>
+    </dependencies>
+    <dependencyManagement>
+    <dependencies>
+        <dependency>
+            <groupId>org.spearce</groupId>
+            <artifactId>org.spearce.jgit</artifactId>
+            <version>${project.version}</version>
+        </dependency>
+        <dependency>
+            <groupId>com.jcraft</groupId>
+            <artifactId>jsch</artifactId>
+            <version>0.1.38</version>
+        </dependency>
+        <dependency>
+            <groupId>args4j</groupId>
+            <artifactId>args4j</artifactId>
+            <version>2.0.9</version>
+        </dependency>            
+    </dependencies>
+    </dependencyManagement>
+    <distributionManagement>
+        <snapshotRepository>
+            <id>jgit-maven-snapshot-repository</id>
+            <name>JGit Maven Snapshot Repository</name>
+            <url>dav:https://egit.googlecode.com/svn/maven/snapshot-repository/</url>
+            <uniqueVersion>true</uniqueVersion>
+        </snapshotRepository>
+    </distributionManagement>
+    <modules>
+      <module>org.spearce.jgit</module>
+      <module>org.spearce.jgit.test</module>   
+      <module>org.spearce.jgit.pgm</module>               
+    </modules>
+    <profiles>
+      <!-- Release -->      
+      <profile>
+        <id>jgit-release</id>
+        <build>
+        <plugins>
+          <!-- We want to sign the artifact, the POM, and all attached artifacts -->
+          <plugin>
+            <groupId>org.apache.maven.plugins</groupId>
+            <artifactId>maven-gpg-plugin</artifactId>
+            <configuration>
+              <passphrase>${gpg.passphrase}</passphrase>
+            </configuration>
+            <executions>
+              <execution>
+                <goals>
+                  <goal>sign</goal>
+                </goals>
+              </execution>
+            </executions>
+          </plugin>
+          <!-- We want to deploy the artifact to a staging location for perusal -->
+          <plugin>
+            <inherited>true</inherited>
+            <groupId>org.apache.maven.plugins</groupId>
+            <artifactId>maven-deploy-plugin</artifactId>
+            <configuration>
+              <updateReleaseInfo>true</updateReleaseInfo>
+            </configuration>
+          </plugin>
+          <plugin>
+            <groupId>org.apache.maven.plugins</groupId>
+            <artifactId>maven-source-plugin</artifactId>
+            <executions>
+              <execution>
+                <id>attach-sources</id>
+                <goals>
+                  <goal>jar</goal>
+                </goals>
+              </execution>
+            </executions>
+          </plugin>
+          <plugin>
+            <groupId>org.apache.maven.plugins</groupId>
+            <artifactId>maven-javadoc-plugin</artifactId>
+            <configuration>
+              <encoding>${project.build.sourceEncoding}</encoding>
+            </configuration>
+            <executions>
+              <execution>
+                <id>attach-javadocs</id>
+                <goals>
+                  <goal>jar</goal>
+                </goals>
+              </execution>
+            </executions>
+          </plugin>
+        </plugins>        
+        </build>
+      </profile>
+    </profiles>
+</project>
-- 
1.6.2.5
