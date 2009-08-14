From: John Bito <jwbito@gmail.com>
Subject: Re: [EGIT] Push to GitHub caused corruption
Date: Fri, 14 Aug 2009 09:17:22 -0700
Message-ID: <3ae83b000908140917j111352f0pe728d99711466e7a@mail.gmail.com>
References: <3ae83b000908101446q2d4f1101we4bbd7023f78b03@mail.gmail.com>
	 <200908110810.45369.robin.rosenberg@gmail.com>
	 <3ae83b000908111552o53189a44h45fc44f124850483@mail.gmail.com>
	 <200908141119.49798.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 18:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbzTA-0003yS-Hw
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 18:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbZHNQRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 12:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbZHNQRX
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 12:17:23 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:35947 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839AbZHNQRW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 12:17:22 -0400
Received: by gxk1 with SMTP id 1so2142690gxk.17
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tqFh7GyLubIM/LOI9CI23ltQ+MrtJvfOdu0B5vYjqbQ=;
        b=l83+Gu8QtQu9pQVZXS1m2X8pINYIjTPNP99CCtf2rLafGlZulHrKFa4Yx0ST5nxBhu
         Ny5CmNSGdVG3AqoHT1zsOqMDic4oQVIh19eXB42oQ98dcEKpOhcN/ZG7S/KcfZ0foVbt
         ElT7XHQAzM5rTXh5bkW6/4HnXKk0Xc4Dfos1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kEYSu06ntGVdqXD88bO01WW2DokjPmI9K0m00jvqO4NkL/smp8kuU/7burpZShckn4
         kyzPgauhIrm59cBdZFz01qf+hRTSQzBJB4Ae7vNZEXGpvv+xPTZy/cfa8nAQvZI2Hk/U
         ote1BeD6ZRlRusOkoZXda0IYWqwnqOvoBrx6M=
Received: by 10.91.204.23 with SMTP id g23mr1187683agq.19.1250266642319; Fri, 
	14 Aug 2009 09:17:22 -0700 (PDT)
In-Reply-To: <200908141119.49798.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125936>

The repo that was pushed to cause the corruption GitHup has the tree
entry f4f9ecd1875938baa42467dfd6a8134d75fe5de4 in a dangling commit.

I've opened a bug in hopes that will limit the chatter on this list:
https://bugs.eclipse.org/bugs/show_bug.cgi?id=286653

The information below is all in there, as well.

$ git fsck --full f4f9ecd1875938baa42467dfd6a8134d75fe5de4
dangling commit 560a391801d1712b625d4ae317a490529a4ccf08

$ git ls-tree f4f9ecd1875938baa42467dfd6a8134d75fe5de4
100644 blob 9324c851e6816962f87cb772ebc34f9c8036d832    .classpath
100644 blob 1cb465bc1e95c2e088376ac06b363a3aa481c9ce    .project
040000 tree f00fa742e906037190ae0cce70ec235fbf6eab83    .settings
100644 blob 7186ec1ee04722679dd9b8c0567fa522ac0495b3    asql.jardesc
040000 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904    bin-groovy
040000 tree 57548924f1eca854dc8db00844f95d3de2c82957    bin
040000 tree 1156d24cd387c7278bc536d32b09057556a6c60d    lib
040000 tree 3d1f74522c3e7c3c03390fae376446fda6eed306    src

$ git show 560a391801d1712b625d4ae317a490529a4ccf08
commit 560a391801d1712b625d4ae317a490529a4ccf08
Author: John W. Bito <jwbito@XXXX>
Date:   Mon Aug 10 14:01:22 2009 -0700

    Now traverse rows using DB cursor.  Enable statement cache.

diff --git a/ADS/testlib/asql.jar b/ADS/testlib/asql.jar
index bb434c7..155b825 100644
Binary files a/ADS/testlib/asql.jar and b/ADS/testlib/asql.jar differ
diff --git a/ADS/testlib/groovy-all-1.6.1.jar b/ADS/testlib/groovy-all-1.6.1.jar
deleted file mode 100644
index a6252c2..0000000
Binary files a/ADS/testlib/groovy-all-1.6.1.jar and /dev/null differ
diff --git a/ADS/testlib/groovy-all-1.7-beta-1-SNAPSHOT.jar
b/ADS/testlib/groovy-all-1.7-beta-1-SNAPSHOT.jar
new file mode 100644
index 0000000..4d3fec8
Binary files /dev/null and
b/ADS/testlib/groovy-all-1.7-beta-1-SNAPSHOT.jar differ
diff --git a/queryengine/.classpath b/queryengine/.classpath
index 4aab135..9324c85 100644
--- a/queryengine/.classpath
+++ b/queryengine/.classpath
@@ -1,17 +1,17 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<classpath>
-	<classpathentry excluding="ch/viveo/query/test/resources/"
kind="src" path="src"/>
-	<classpathentry
excluding="bin-groovy/|src/|src/ch/viveo/query/test/resources/"
kind="src" path=""/>
-	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
-	<classpathentry exported="true" kind="con" path="GROOVY_SUPPORT"/>
-	<classpathentry combineaccessrules="false" kind="src" path="/nb_binding"/>
-	<classpathentry kind="con" path="org.eclipse.jdt.junit.JUNIT_CONTAINER/4"/>
-	<classpathentry kind="con"
path="org.eclipse.datatools.connectivity.jdt.DRIVERLIBRARY/Oracle Thin
Driver"/>
-	<classpathentry kind="lib" path="/nb_binding/lib/xpp3_min-1.1.4c.jar"/>
-	<classpathentry kind="lib" path="/nb_binding/lib/xstream-1.3.1.jar">
-		<attributes>
-			<attribute name="javadoc_location"
value="http://xstream.codehaus.org/javadoc"/>
-		</attributes>
-	</classpathentry>
-	<classpathentry kind="output" path="bin"/>
-</classpath>
+<?xml version="1.0" encoding="UTF-8"?>
+<classpath>
+	<classpathentry excluding="ch/viveo/query/test/resources/"
kind="src" path="src"/>
+	<classpathentry
excluding="bin-groovy/|src/|src/ch/viveo/query/test/resources/"
kind="src" path=""/>
+	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
+	<classpathentry combineaccessrules="false" kind="src" path="/nb_binding"/>
+	<classpathentry kind="con" path="org.eclipse.jdt.junit.JUNIT_CONTAINER/4"/>
+	<classpathentry kind="con"
path="org.eclipse.datatools.connectivity.jdt.DRIVERLIBRARY/Oracle Thin
Driver"/>
+	<classpathentry kind="lib" path="/nb_binding/lib/xpp3_min-1.1.4c.jar"/>
+	<classpathentry kind="lib" path="/nb_binding/lib/xstream-1.3.1.jar">
+		<attributes>
+			<attribute name="javadoc_location"
value="http://xstream.codehaus.org/javadoc"/>
+		</attributes>
+	</classpathentry>
+	<classpathentry exported="true" kind="con" path="GROOVY_SUPPORT"/>
+	<classpathentry kind="output" path="bin"/>
+</classpath>
diff --git a/queryengine/.settings/org.codehaus.groovy.eclipse.preferences.prefs
b/queryengine/.settings/org.codehaus.groovy.eclipse.preferences.prefs
old mode 100755
new mode 100644
index 1abf79e..c5e9a2e
--- a/queryengine/.settings/org.codehaus.groovy.eclipse.preferences.prefs
+++ b/queryengine/.settings/org.codehaus.groovy.eclipse.preferences.prefs
@@ -1,4 +1,4 @@
-#Tue May 05 14:16:49 PDT 2009
+#Sat Aug 08 14:15:43 PDT 2009
 eclipse.preferences.version=1
 groovy.compiler.output.path=bin-groovy
 support.groovy=true
diff --git a/queryengine/bin-groovy/README b/queryengine/bin-groovy/README
deleted file mode 100644
index 6dd996e..0000000
--- a/queryengine/bin-groovy/README
+++ /dev/null
@@ -1 +0,0 @@
-Folder for Groovy compilation.
diff --git a/queryengine/bin/.settings/org.codehaus.groovy.eclipse.preferences.prefs
b/queryengine/bin/.settings/org.codehaus.groovy.eclipse.preferences.prefs
old mode 100755
new mode 100644
index 1abf79e..c5e9a2e
--- a/queryengine/bin/.settings/org.codehaus.groovy.eclipse.preferences.prefs
+++ b/queryengine/bin/.settings/org.codehaus.groovy.eclipse.preferences.prefs
@@ -1,4 +1,4 @@
-#Tue May 05 14:16:49 PDT 2009
+#Sat Aug 08 14:15:43 PDT 2009
 eclipse.preferences.version=1
 groovy.compiler.output.path=bin-groovy
 support.groovy=true
diff --git a/queryengine/src/ch/viveo/query/TableBinding.groovy
b/queryengine/src/ch/viveo/query/TableBinding.groovy
index 29e0e58..410ebd6 100644
--- a/queryengine/src/ch/viveo/query/TableBinding.groovy
+++ b/queryengine/src/ch/viveo/query/TableBinding.groovy
@@ -7,6 +7,7 @@ import ch.viveo.ads_sql.TableInterface ;
 import ch.viveo.ads_sql.buffer.ClientBuffer;
 import ch.viveo.ads_sql.exceptions.*;
 import groovy.sql.Sql ;
+import groovy.sql.GroovyResultSet ;
 import java.util.logging.Logger;
 import java.util.logging.Level;
 import java.nio.ByteBuffer;
@@ -19,20 +20,20 @@ import java.lang.IllegalStateException
  *
  */
 public class TableBinding implements TableInterface {
+	private static final Logger log =
Logger.getLogger(getClass().getSimpleName());
+
 	private final Structure str;
 	private final Table tab;
 	private final def db;
 	private final def allFieldNames;
-	private final Set<Object> allColumnNames;
+	private final Set<String> allColumnNames;
 	private boolean valid;
 	private boolean open;
 	private def uri;
-	private def rowSet;
+	private GroovyResultSet resultSet;
 	private def queryParams;
 	private def queryKey;
 	private int queryMatchType;
-	private boolean rowSetUsed;
-	private static final Logger log =
Logger.getLogger(getClass().getSimpleName());
 	private final String readQuery;
 	private final String maxUriQuery;
 	private final String sequenceQuery;
@@ -195,8 +196,7 @@ public class TableBinding implements TableInterface {
 	
 	void select(int lockOption){
 		log.log(Level.FINEST, "Parameters: {0}", queryParams)
-		rowSet = db.rows(tab.keys.(lockOption ? "queryStringLock" :
"queryString") (queryKey, queryMatchType), queryParams);
-		rowSetUsed = false;
+		resultSet = db.rowCursor(tab.keys.(lockOption ? "queryStringLock" :
"queryString") (queryKey, queryMatchType), queryParams);
 	}
 	
 	public void selectRange(int keyNumber, int matchOption, ByteBuffer
startValues, ByteBuffer endValues) {
@@ -209,29 +209,23 @@ public class TableBinding implements TableInterface {
 	}

 	private reset() {
-		rowSet = null;
-		rowSetUsed = false
+		if (resultSet && !resultSet.isClosed())
+			resultSet.close();
 	}
 	
 	public int retrieveUris(ByteBuffer result, int lockOption) {
-		if (null == rowSet) {
+		if (null == resultSet) {
 			if (!queryKey)
 				throw new IllegalStateException("No row set available for ${tab.name}");
 			else {
 				select(lockOption);
-				log.log(Level.FINEST, "Select URIs returns {0}: {1}",
rowSet.size(), rowSet)
 			}
 		}
-		if (rowSetUsed)
-			return 0;
-		rowSetUsed = true;
 		IntBuffer urilist = result.asIntBuffer();
 		int count = 0;
-		rowSet.each {
-			if (urilist.position() < urilist.limit()) {
-				urilist.put(it.uri as int)
-				count ++;
-			}
+		while (urilist.position() < urilist.limit() && resultSet.next()) {
+			urilist.put(resultSet.uri as int)
+			count ++;
 		}
 		log.log(Level.FINEST, "retrieveUris returning {0} uris", count);
 		//TODO hold pagination state so next request returns following list elements
@@ -239,6 +233,7 @@ public class TableBinding implements TableInterface {
 	}
 	
 	public void close() {
+		reset();
 		valid = false;
 		open = false;
 		//TODO remove the reference to this in the Process instance
diff --git a/queryengine/src/ch/viveo/query/TableBindingTest.groovy
b/queryengine/src/ch/viveo/query/TableBindingTest.groovy
index 8e2a389..aa448d1 100644
--- a/queryengine/src/ch/viveo/query/TableBindingTest.groovy
+++ b/queryengine/src/ch/viveo/query/TableBindingTest.groovy
@@ -8,7 +8,6 @@ import org.junit.Test
 import org.junit.Before
 import org.junit.After;

-import groovy.sql.Sql;
 import java.nio.ByteBuffer;
 import java.nio.IntBuffer;

@@ -18,6 +17,9 @@ import ch.viveo.ads_sql.TableInterface
 import ch.viveo.ads_sql.buffer.ClientBuffer
 import ch.viveo.ads_sql.test.TestData

+import ch.viveo.query.mgr.Process;
+import ch.viveo.query.sql.SqlCursor;
+
 /**
  * @author John W. Bito
  *
@@ -27,13 +29,17 @@ public class TableBindingTest extends GroovyTestCase {
     def db = null;
     def str, res, fdf, keys;
     ByteBuffer buff;
+
+    public static final String TEST_DRIVER = 'oracle.jdbc.driver.OracleDriver';

     @Before
     public void setUp() throws Exception {
         resource = TestData.genericResource("clienp01.info.xml", this);
         fdf = new FDFTranslator().readXML(new FileReader(resource));
         str = FDFTranslator.createStructure(fdf);
-        db = Sql.newInstance("jdbc:oracle:thin:nbquali5/nbquali51@localhost:1521:nb");
+        Class.forName(TEST_DRIVER)
+        System.setProperty(Process.JDBC_DRIVER_PROPERTY, TEST_DRIVER)
+        db = SqlCursor.newInstance("jdbc:oracle:thin:nbquali5/nbquali51@localhost:1521:nb");
         def tab = new Table("uri_clienp01");
 		res = new TableBinding(str, tab, db);
 		keys = new KeyBinding(tab, str, fdf.key.code);
@@ -65,6 +71,10 @@ public class TableBindingTest extends GroovyTestCase {
 		def rec = readLast();
 		String query = "select * from uri_clienp01 where uri=${res.uri}";
 		def sqlData = db.firstRow(query);
+		sqlData.each { k, v ->
+			println k + "->" + v?.class + "=" + v
+			
+		}
 		assertEquals(sqlData["MAJ0H"], rec["MAJ0H"].value);
 		assertTrue(res.getUnboundColumns().isEmpty());
 		assertTrue(res.getUnboundFields().isEmpty());
@@ -121,7 +131,7 @@ public class TableBindingTest extends GroovyTestCase {
 		
 		res.selectRange(0, TableInterface.MATCHGEKEY1LEKEY2, start, end);
 		res.select(01);
-		assertEquals(12, res.rowSet.size());
+		assertEquals(4, res.queryParams.size());
 	}
 	
 	@Test
diff --git a/queryengine/src/ch/viveo/query/mgr/Process.groovy
b/queryengine/src/ch/viveo/query/mgr/Process.groovy
index 9613e2a..5bce4ed 100644
--- a/queryengine/src/ch/viveo/query/mgr/Process.groovy
+++ b/queryengine/src/ch/viveo/query/mgr/Process.groovy
@@ -4,13 +4,13 @@
 package ch.viveo.query.mgr ;

 import java.nio.ByteBuffer ;
-import groovy.sql.Sql;
 import java.sql.Connection;

 import ch.viveo.ads_sql.FDFTranslator;
 import ch.viveo.ads_sql.TableInterface;

 import ch.viveo.query.*;
+import ch.viveo.query.sql.SqlCursor;

 /**
  * Handle the lifecycle of PDs (Process Definition) and the resources
that map to SQL queries
@@ -28,6 +28,7 @@ public class Process{
 	def dbConnection = null;
 	
 	public static final String CONNECTION_PROPERTY = "ch.viveo.db.connect";
+	public static final String JDBC_DRIVER_PROPERTY = "ch.viveo.db.driver";
 	
 	FDFTranslator loader = null;
 	
@@ -49,10 +50,13 @@ public class Process{
 	private def getConnection() {
 		if (!dbConnection) {
 			String connSpec = System.getProperty(CONNECTION_PROPERTY);
+			String driverName = System.getProperty(JDBC_DRIVER_PROPERTY);
 			if (!connSpec)
 				throw new IllegalArgumentException("$CONNECTION_PROPERTY not set");
-			Class.forName("oracle.jdbc.driver.OracleDriver"); // TODO setup a
proper initialization
-			dbConnection = Sql.newInstance(connSpec);
+			if (driverName)
+				dbConnection = SqlCursor.newInstance(connSpec, driverName);
+			else
+				dbConnection = SqlCursor.newInstance(connSpec);
 		}
 		return dbConnection;
 	}
diff --git a/queryengine/src/ch/viveo/query/sql/SqlCursor.java
b/queryengine/src/ch/viveo/query/sql/SqlCursor.java
new file mode 100644
index 0000000..232ccd3
--- /dev/null
+++ b/queryengine/src/ch/viveo/query/sql/SqlCursor.java
@@ -0,0 +1,149 @@
+/**
+ *
+ */
+package ch.viveo.query.sql;
+
+import java.sql.Connection;
+import java.sql.DriverManager;
+import java.sql.ResultSet;
+import java.sql.SQLException;
+import java.util.List;
+import java.util.Properties;
+
+import javax.sql.DataSource;
+
+import groovy.sql.GroovyResultSet;
+import groovy.sql.GroovyResultSetProxy;
+import groovy.sql.Sql;
+
+/**
+ * @author IBM User
+ *
+ */
+public class SqlCursor extends Sql {
+
+	/**
+	 * @param dataSource
+	 */
+	public SqlCursor(DataSource dataSource) {
+		super(dataSource);
+		setCacheStatements(true);
+	}
+
+	/**
+	 * @param connection
+	 */
+	public SqlCursor(Connection connection) {
+		super(connection);
+		setCacheStatements(true);
+	}
+
+    /**
+     * Creates a new Sql instance given a JDBC connection URL.
+     *
+     * @param url a database url of the form
+     *            <code> jdbc:<em>subprotocol</em>:<em>subname</em></code>
+     * @return a new Sql instance with a connection
+     * @throws SQLException if a database access error occurs
+     */
+    public static SqlCursor newInstance(String url) throws SQLException {
+        Connection connection = DriverManager.getConnection(url);
+        return new SqlCursor(connection);
+    }
+
+    /**
+     * Creates a new Sql instance given a JDBC connection URL
+     * and some properties.
+     *
+     * @param url        a database url of the form
+     *                   <code>
jdbc:<em>subprotocol</em>:<em>subname</em></code>
+     * @param properties a list of arbitrary string tag/value pairs
+     *                   as connection arguments; normally at least a
"user" and
+     *                   "password" property should be included
+     * @return a new Sql instance with a connection
+     * @throws SQLException if a database access error occurs
+     */
+    public static SqlCursor newInstance(String url, Properties
properties) throws SQLException {
+        Connection connection = DriverManager.getConnection(url, properties);
+        return new SqlCursor(connection);
+    }
+
+    /**
+     * Creates a new Sql instance given a JDBC connection URL,
+     * some properties and a driver class name.
+     *
+     * @param url             a database url of the form
+     *                        <code>
jdbc:<em>subprotocol</em>:<em>subname</em></code>
+     * @param properties      a list of arbitrary string tag/value pairs
+     *                        as connection arguments; normally at
least a "user" and
+     *                        "password" property should be included
+     * @param driverClassName the fully qualified class name of the
driver class
+     * @return a new Sql instance with a connection
+     * @throws SQLException           if a database access error occurs
+     * @throws ClassNotFoundException if the class cannot be found or loaded
+     */
+    public static SqlCursor newInstance(String url, Properties
properties, String driverClassName)
+            throws SQLException, ClassNotFoundException {
+        loadDriver(driverClassName);
+        return newInstance(url, properties);
+    }
+
+    /**
+     * Creates a new Sql instance given a JDBC connection URL,
+     * a username and a password.
+     *
+     * @param url      a database url of the form
+     *                 <code> jdbc:<em>subprotocol</em>:<em>subname</em></code>
+     * @param user     the database user on whose behalf the connection
+     *                 is being made
+     * @param password the user's password
+     * @return a new Sql instance with a connection
+     * @throws SQLException if a database access error occurs
+     */
+    public static SqlCursor newInstance(String url, String user,
String password) throws SQLException {
+        Connection connection = DriverManager.getConnection(url,
user, password);
+        return new SqlCursor(connection);
+    }
+
+    /**
+     * Creates a new Sql instance given a JDBC connection URL,
+     * a username, a password and a driver class name.
+     *
+     * @param url             a database url of the form
+     *                        <code>
jdbc:<em>subprotocol</em>:<em>subname</em></code>
+     * @param user            the database user on whose behalf the connection
+     *                        is being made
+     * @param password        the user's password
+     * @param driverClassName the fully qualified class name of the
driver class
+     * @return a new Sql instance with a connection
+     * @throws SQLException           if a database access error occurs
+     * @throws ClassNotFoundException if the class cannot be found or loaded
+     */
+    public static SqlCursor newInstance(String url, String user,
String password, String driverClassName) throws SQLException,
+            ClassNotFoundException {
+        loadDriver(driverClassName);
+        return newInstance(url, user, password);
+    }
+
+    /**
+     * Creates a new Sql instance given a JDBC connection URL
+     * and a driver class name.
+     *
+     * @param url             a database url of the form
+     *                        <code>
jdbc:<em>subprotocol</em>:<em>subname</em></code>
+     * @param driverClassName the fully qualified class name of the
driver class
+     * @return a new Sql instance with a connection
+     * @throws SQLException           if a database access error occurs
+     * @throws ClassNotFoundException if the class cannot be found or loaded
+     */
+    public static SqlCursor newInstance(String url, String
driverClassName) throws SQLException, ClassNotFoundException {
+        loadDriver(driverClassName);
+        return newInstance(url);
+    }
+
+    public GroovyResultSet rowCursor(String sql, List<Object> params)
throws SQLException {
+    	ResultSet rs = executePreparedQuery(sql, params);
+    	return new GroovyResultSetProxy(rs).getImpl();
+    }
+
+}
diff --git a/queryengine/src/nb.sql b/queryengine/src/nb.sql
index 277ff44..7c2c875 100644
--- a/queryengine/src/nb.sql
+++ b/queryengine/src/nb.sql
@@ -100,4 +100,8 @@ delete from clienp01 where uri > 1500;
 desc uri_clienp01;

 select distinct nom0x from clienp01
-select uri from clienp01 where nom0x = 'CL99898000'
\ No newline at end of file
+select uri from clienp01 where nom0x = 'CL99898000'
+
+alter table uri_clienp01 add  (time timestamp)
+alter table uri_clienp01 drop column time
+update uri_clienp01 set time = current_timestamp
\ No newline at end of file


On Fri, Aug 14, 2009 at 02:19, Robin
Rosenberg<robin.rosenberg.lists@dewire.com> wrote:
> f4f9ecd1875938baa42467dfd6a8134d75fe5de4
