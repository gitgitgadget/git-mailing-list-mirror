From: Adam Retter <adam@exist-db.org>
Subject: git svn error "Not a valid object name"
Date: Mon, 11 Mar 2013 22:17:35 +0000
Message-ID: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dannes Wessels <dannes@exist-db.org>,
	Wolfgang Meier <wolfgang@exist-db.org>,
	=?UTF-8?B?TGVpZi1Kw7ZyYW4gT2xzc29u?= <ljo@exist-db.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 23:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFB2i-0005si-LY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 23:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab3CKWRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 18:17:38 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34158 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab3CKWRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 18:17:36 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so5010293oag.22
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 15:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type:x-gm-message-state;
        bh=4eDbRkQImYaV67L6C7MqsC37MZRdZ+mAwZTU4N0oMYU=;
        b=PB0ocNLVB5CNnjNrEi7U9U1Tdjht6XADNhdz/UakTiTvKtBOZTRvNcFK4CH3vuTQul
         tziYw/125TunPYQhe8tE304ERstESvO5ZFvW286z2cTwISb/RU43reNtOc5bW6BFhmM2
         I6MTnt2Q89e/bRtg1eAvUQUTgJFd6h2XckfRhMZIemPNLyl+oM1Z2n++sQurvKscurI5
         eEZN0GJUUgUHl4YINljMPfy7gFXoE45zSsSxkMuFK+T0aBqVLZ18rq9jSWb0iYcf6pWd
         HYAD0EUKAWLZInOakcX+uS9RJ5t7BsDcOHp7vIwlCxbCzagY5+wZAb83DaqR8r7bkDKc
         CTIg==
X-Received: by 10.60.31.170 with SMTP id b10mr10365731oei.34.1363040255793;
 Mon, 11 Mar 2013 15:17:35 -0700 (PDT)
Received: by 10.76.33.166 with HTTP; Mon, 11 Mar 2013 15:17:35 -0700 (PDT)
X-Gm-Message-State: ALoCoQk1VFZZouzQVtq4rKBThsInvnjHHhpYhOBLhdv9tliejXNinGmtbRGUFN+E2KoF1QB4/Snb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217919>

Hi there,

We have been attempting to move our smallish SVN repository for our
Open Source project (ww.exist-db.org) from SourceForge over to GitHub
and it is not going well at all.

We started with svn2git as recommended by GitHub and that didnt work,
we are not on to using 'git svn' directly. If you want the backlog of
detail its here - http://markmail.org/message/khjx6n2jbvcdnnf5

Our public SourceForge Subversion repository is here:
http://svn.code.sf.net/p/exist/code/trunk/eXist

We cloned that to the local server using rsync and are attempting to
migrate to git using the following commands:

$ git svn init -t tags -b stable -T trunk
file:///home/ec2-user/svn-rsync/code new-git-repo
$ cd new-git-repo
$ git config svn-remote.svn.preserve-empty-dirs true
$ git config svn-remote.svn.rewriteRoot https://svn.code.sf.net/p/exist/code
$ git svn fetch -A /home/ec2-user/.svn2git/authors.txt

It all started well and was running away for quite some hours, when
the following error occurred:

fatal: Not a valid object name
ls-tree -z  ./webapp/api/: command returned error: 128

I have no idea what this means, or how to fix this.
We are using Git version 1.8.1.GIT on Amazon EC2 Linux.

Any suggestions please?

I reproduce the log of the last two revisions output from running 'git
svn fetch ...' below, in case that provides any clues:

r3447 = e7d8dd23f78464228128e9b72711c5722b07ad42 (refs/remotes/trunk)
        M       eXist-1.0/src/org/exist/xquery/test/XQueryFunctionsTest.java
        M       eXist-1.0/src/org/exist/xquery/functions/FunString.java
r3448 = 811a870bb7b83d36ce41b2afab39b2fecf59803d (refs/remotes/trunk)
Found possible branch point:
file:///home/ec2-user/svn-rsync/code/trunk/eXist-1.0 =>
file:///home/ec2-user/svn-rsync/code/tags/DLN3445-pre-merge, 3452
Initializing parent: refs/remotes/tags/DLN3445-pre-merge@3452
        A       conf.xml
        A       src/org/exist/xmldb.xsl
        A       src/org/exist/Parser.java
        A       src/org/exist/util/LockOwner.java
        A       src/org/exist/util/CollectionScanner.java
        A       src/org/exist/util/SyntaxException.java
        A       src/org/exist/util/VariableByteInputStream.java
        A       src/org/exist/util/VariableByteOutputStream.java
        A       src/org/exist/util/LockException.java
        A       src/org/exist/util/Configuration.java
        A       src/org/exist/util/OrderedLinkedList.java
        A       src/org/exist/util/XMLFilenameFilter.java
        A       src/org/exist/util/PorterStemmer.java
        A       src/org/exist/util/SimpleTimeOutLock.java
        A       src/org/exist/util/ByteConversion.java
        A       src/org/exist/util/ProgressListener.java
        A       src/org/exist/util/IncludeXMLFilter.java
        A       src/org/exist/util/DatabaseConfigurationException.java
        A       src/org/exist/util/FastByteBuffer.java
        A       src/org/exist/util/Lockable.java
        A       src/org/exist/util/DirectoryScanner.java
        A       src/org/exist/util/FastStringBuffer.java
        A       src/org/exist/util/LongLinkedList.java
        A       src/org/exist/util/Lock.java
        A       src/org/exist/util/ProgressBar.java
        A       src/org/exist/util/LongArrayList.java
        A       src/org/exist/util/ReadOnlyException.java
        A       src/org/exist/util/VariableByteCoding.java
        A       src/org/exist/util/XMLUtil.java
        A       src/org/exist/util/test/VariableByteStreamTest.java
        A       src/org/exist/util/ObjectPool.java
        A       src/org/exist/util/Arrays.java
        A       src/org/exist/util/ProgressIndicator.java
        A       src/org/exist/util/SelectorUtils.java
        A       src/org/exist/http/HttpServer.java
        A       src/org/exist/http/HttpServerConnection.java
        A       src/org/exist/dom/NodeListImpl.java
        A       src/org/exist/dom/TextImpl.java
        A       src/org/exist/dom/NodeImpl.java
        A       src/org/exist/dom/VirtualNodeSet.java
        A       src/org/exist/dom/CharacterDataImpl.java
        A       src/org/exist/dom/NamedNodeMapImpl.java
        A       src/org/exist/dom/ElementImpl.java
        A       src/org/exist/dom/SymbolTable.java
        A       src/org/exist/dom/NodeIDSet.java
        A       src/org/exist/dom/NodeProxyFactory.java
        A       src/org/exist/dom/EmptyNodeSet.java
        A       src/org/exist/dom/SortedNodeSet.java
        A       src/org/exist/dom/DocumentFragmentImpl.java
        A       src/org/exist/dom/CommentImpl.java
        A       src/org/exist/dom/DOMImplementation.java
        A       src/org/exist/dom/NodeProxy.java
        A       src/org/exist/dom/DocumentIterator.java
        A       src/org/exist/dom/DocumentSet.java
        A       src/org/exist/dom/ArraySet.java
        A       src/org/exist/dom/Collection.java
        A       src/org/exist/dom/AttrImpl.java
        A       src/org/exist/dom/ProcessingInstructionImpl.java
        A       src/org/exist/dom/DocumentImpl.java
        A       src/org/exist/dom/NodeSet.java
        A       src/org/exist/dom/.ElementImpl.java.swp
        A       src/org/exist/dom/DocumentTypeImpl.java
        A       src/org/exist/cocoon/XMLDBSessionLoginAction.java
        A       src/org/exist/cocoon/XSPHelper.java
        A       src/org/exist/cocoon/Exist.java
        A       src/org/exist/cocoon/ExistImpl.java
        A       src/org/exist/xpath/Literal.java
        A       src/org/exist/xpath/FunNear.java
        A       src/org/exist/xpath/FunEndsWith.java
        A       src/org/exist/xpath/Expression.java
        A       src/org/exist/xpath/FunRound.java
        A       src/org/exist/xpath/Predicate.java
        A       src/org/exist/xpath/OpAnd.java
        A       src/org/exist/xpath/IntNumber.java
        A       src/org/exist/xpath/ValueString.java
        A       src/org/exist/xpath/FunKeywordMatchAll.java
        A       src/org/exist/xpath/Environment.java
        A       src/org/exist/xpath/LocationStep.java
        A       src/org/exist/xpath/FunId.java
        A       src/org/exist/xpath/FunNot.java
        A       src/org/exist/xpath/FunKeywordMatch.java
        A       src/org/exist/xpath/FLWR.java
        A       src/org/exist/xpath/Value.java
        A       src/org/exist/xpath/FunLast.java
        A       src/org/exist/xpath/ValueBoolean.java
        A       src/org/exist/xpath/FunPosition.java
        A       src/org/exist/xpath/FunSum.java
        A       src/org/exist/xpath/FunString.java
        A       src/org/exist/xpath/OpOr.java
        A       src/org/exist/xpath/NameTest.java
        A       src/org/exist/xpath/FunStrLength.java
        A       src/org/exist/xpath/BinaryOp.java
        A       src/org/exist/xpath/FunCeiling.java
        A       src/org/exist/xpath/VarBinding.java
        A       src/org/exist/xpath/ValueNumber.java
        A       src/org/exist/xpath/NodeTest.java
        A       src/org/exist/xpath/AnyTest.java
        A       src/org/exist/xpath/FunTrue.java
        A       src/org/exist/xpath/FunBoolean.java
        A       src/org/exist/xpath/ValueSet.java
        A       src/org/exist/xpath/FunName.java
        A       src/org/exist/xpath/OpEquals.java
        A       src/org/exist/xpath/RootNode.java
        A       src/org/exist/xpath/PathExpr.java
        A       src/org/exist/xpath/ValueException.java
        A       src/org/exist/xpath/ValueNodeSet.java
        A       src/org/exist/xpath/FunNumber.java
        A       src/org/exist/xpath/FunCount.java
        A       src/org/exist/xpath/OpNumeric.java
        A       src/org/exist/xpath/FunFalse.java
        A       src/org/exist/xpath/Step.java
        A       src/org/exist/xpath/Constants.java
        A       src/org/exist/xpath/TypeTest.java
        A       src/org/exist/xpath/FunKeywordMatchAny.java
        A       src/org/exist/xpath/Function.java
        A       src/org/exist/xpath/FunStartsWith.java
        A       src/org/exist/xpath/FunContains.java
        A       src/org/exist/xpath/Union.java
        A       src/org/exist/xpath/FunSubstring.java
        A       src/org/exist/xpath/FunFloor.java
        A       src/org/exist/Backup.java
        A       src/org/exist/Server.java
        A       src/org/exist/EXistException.java
        A       src/org/exist/InteractiveClient.java
        A       src/org/exist/parser/XPathParser.g
        A       src/org/exist/xmldb2.xsl
        A       src/org/exist/exist.xsl
        A       src/org/exist/DatabaseAdminServlet.java
        A       src/org/exist/soap/QueryServiceLocator.java
        A       src/org/exist/soap/AdminSoapBindingSkeleton.java
        A       src/org/exist/soap/deploy.wsdd
        A       src/org/exist/soap/undeploy.wsdd
        A       src/org/exist/soap/admin.wsdl
        A       src/org/exist/soap/QuerySoapBindingStub.java
        A       src/org/exist/soap/QueryResponseDocument.java
        A       src/org/exist/soap/QueryResponse.java
        A       src/org/exist/soap/QueryService.java
        A       src/org/exist/soap/Admin.java
        A       src/org/exist/soap/AdminSoapBindingImpl.java
        A       src/org/exist/soap/QuerySoapBindingSkeleton.java
        A       src/org/exist/soap/Collection.java
        A       src/org/exist/soap/query.wsdl
        A       src/org/exist/soap/AdminServiceLocator.java
        A       src/org/exist/soap/QueryResponseCollection.java
        A       src/org/exist/soap/AdminSoapBindingStub.java
        A       src/org/exist/soap/Query.java
        A       src/org/exist/soap/QuerySoapBindingImpl.java
        A       src/org/exist/soap/Sessions.java
        A       src/org/exist/soap/AdminService.java
        A       src/org/exist/GetServlet.java
        A       src/org/exist/ServletTest.java
        A       src/org/exist/storage/ElementIndex.java
        A       src/org/exist/storage/BFile.java
        A       src/org/exist/storage/NativeTextEngine.java
        A       src/org/exist/storage/ElementPool.java
        A       src/org/exist/storage/Signatures.java
        A       src/org/exist/storage/DOMTransaction.java
        A       src/org/exist/storage/RelationalTextEngine.java
        A       src/org/exist/storage/DBWrapper.java
        A       src/org/exist/storage/NativeElementIndex.java
        A       src/org/exist/storage/DBBroker.java
        A       src/org/exist/storage/NativeBroker.java
        A       src/org/exist/storage/ByteBuffer.java
        A       src/org/exist/storage/BFileCallback.java
        A       src/org/exist/storage/RelationalBroker.java
        A       src/org/exist/storage/DBConnectionPool.java
        A       src/org/exist/storage/TextSearchEngine.java
        A       src/org/exist/storage/ObjectPool.java
        A       src/org/exist/storage/analysis/SimpleTokenizer.java
        A       src/org/exist/storage/analysis/TextToken.java
        A
src/org/exist/storage/analysis/StandardTokenizerTokenManager.java
        A       src/org/exist/storage/analysis/StandardTokenizerConstants.java
        A       src/org/exist/storage/analysis/ParseException.java
        A       src/org/exist/storage/analysis/Tokenizer.java
        A       src/org/exist/storage/analysis/StandardTokenizer.java
        A       src/org/exist/storage/analysis/StandardTokenizer.jj
        A       src/org/exist/storage/analysis/Token.java
        A       src/org/exist/storage/analysis/TokenMgrError.java
        A       src/org/exist/storage/analysis/SimpleCharStream.java
        A       src/org/exist/storage/PostgresqlWrapper.java
        A       src/org/exist/storage/WordTokenizer.java
        A       src/org/exist/storage/OracleWrapper.java
        A       src/org/exist/storage/MysqlWrapper.java
        A       src/org/exist/storage/IndexPaths.java
        A       src/org/exist/storage/PgElementIndex.java
        A       src/org/exist/storage/TableInsert.java
        A       src/org/exist/storage/BrokerFactory.java
        A       src/org/exist/storage/serializers/Serializer.java
        A       src/org/exist/storage/serializers/NativeSerializer.java
        A       src/org/exist/storage/serializers/PostgresSerializer.java
        A       src/org/exist/storage/serializers/XIncludeFilter.java
        A       src/org/exist/storage/BrokerPool.java
        A       src/org/exist/storage/DOMFile.java
        A       src/org/exist/xmlrpc/RpcServlet.java
        A       src/org/exist/xmlrpc/RpcServer.java
        A       src/org/exist/xmlrpc/RpcAPI.java
        A       src/org/exist/xmlrpc/AuthenticatedHandler.java
        A       src/org/exist/xmldb/XMLResourceImpl.java
        A       src/org/exist/xmldb/CollectionManagementServiceImpl.java
        A       src/org/exist/xmldb/UserManagementService.java
        A       src/org/exist/xmldb/test/ResourceTest.java
        A       src/org/exist/xmldb/test/XPathQueryTest.java
        A       src/org/exist/xmldb/test/AllTests.java
        A       src/org/exist/xmldb/test/CreateCollectionsTest.java
        A       src/org/exist/xmldb/LocalDatabaseInstanceManager.java
        A       src/org/exist/xmldb/DatabaseInstanceManagerImpl.java
        A       src/org/exist/xmldb/LocalCollection.java
        A       src/org/exist/xmldb/LocalXPathQueryService.java
        A       src/org/exist/xmldb/LocalUserManagementService.java
        A       src/org/exist/xmldb/RemoteXPathQueryService.java
        A       src/org/exist/xmldb/XPathQueryServiceImpl.java
        A       src/org/exist/xmldb/CollectionImpl.java
        A       src/org/exist/xmldb/UserManagementServiceImpl.java
        A       src/org/exist/xmldb/LocalResourceSet.java
        A       src/org/exist/xmldb/LocalXMLResource.java
        A       src/org/exist/xmldb/ResourceIteratorImpl.java
        A       src/org/exist/xmldb/LocalCollectionManagementService.java
        A       src/org/exist/xmldb/DatabaseInstanceManager.java
        A       src/org/exist/xmldb/ResourceSetImpl.java
        A       src/org/exist/xmldb/DatabaseImpl.java
        A       src/org/exist/security/MD5.java
        A       src/org/exist/security/Permission.java
        A       src/org/exist/security/User.java
        A       src/org/exist/security/PermissionDeniedException.java
        A       src/org/exist/security/SecurityManager.java
        A       src/CatalogManager.properties
        A       build.properties
        A       thirdparty/jboss/src/samples/XmlDbClientServiceMBean.java
        A       thirdparty/jboss/src/samples/XmlDbClientService.java
        A       thirdparty/jboss/src/org/exist/jboss/XmlDbService.java
        A       thirdparty/jboss/src/org/exist/jboss/XmlDbServiceMBean.java
        A       thirdparty/jboss/src/org/exist/jboss/exist/EXistService.java
        A
thirdparty/jboss/src/org/exist/jboss/exist/EXistServiceMBean.java
        A       thirdparty/jboss/README
        A       thirdparty/jboss/build.xml
        A       thirdparty/jboss/conf/samples/jboss-service.xml
        A       thirdparty/jboss/conf/eXist/jboss-service.xml
        A       README
        A       QuickStart.html
        A       build.xml
        A       Jetty-4.1.4/bin/orgConvert.sh
        A       Jetty-4.1.4/bin/generateJavaDoc
        A       Jetty-4.1.4/bin/jetty.bat
        A       Jetty-4.1.4/bin/rant
        A       Jetty-4.1.4/bin/jetty.sysvinit
        A       Jetty-4.1.4/bin/release-jetty.sh
        A       Jetty-4.1.4/bin/jetty.sh
        A       Jetty-4.1.4/bin/jettyw98.bat
        A       Jetty-4.1.4/cgi-bin/env.sh
        A       Jetty-4.1.4/cgi-bin/redirect.sh
        A       Jetty-4.1.4/start.jar
        A       Jetty-4.1.4/README.TXT
        A       Jetty-4.1.4/etc/.cvsignore
        A       Jetty-4.1.4/etc/jdbcRealm.properties
        A       Jetty-4.1.4/etc/webdefault.xml
        A       Jetty-4.1.4/etc/stresstest.xml
        A       Jetty-4.1.4/etc/demo.xml
        A       Jetty-4.1.4/etc/demo.mlet
        A       Jetty-4.1.4/etc/nio.xml
        A       Jetty-4.1.4/etc/nbio.xml
        A       Jetty-4.1.4/etc/adminRealmproperties
        A       Jetty-4.1.4/etc/admin.xml
        A       Jetty-4.1.4/etc/htgroup
        A       Jetty-4.1.4/etc/examplesRealm.properties
        A       Jetty-4.1.4/etc/LICENSE.javax.servlet.txt
        A       Jetty-4.1.4/etc/j2me.xml
        A       Jetty-4.1.4/etc/LICENSE.javax.xml.html
        A       Jetty-4.1.4/etc/jetty.policy
        A       Jetty-4.1.4/etc/LICENSE.jmx.txt
        A       Jetty-4.1.4/etc/htaccess
        A       Jetty-4.1.4/etc/htpasswd
        A       Jetty-4.1.4/etc/jetty.xml
        A       Jetty-4.1.4/etc/watchdog.xml
        A       Jetty-4.1.4/etc/stresstestRealm.properties
        A       Jetty-4.1.4/etc/demoRealm.properties
        A       Jetty-4.1.4/etc/LICENSE.jsse.txt
        A       Jetty-4.1.4/etc/adminRealm.properties
        A       Jetty-4.1.4/etc/package-list
        A       Jetty-4.1.4/etc/jettydemo.p12
        A       Jetty-4.1.4/etc/demokeystore
        A       Jetty-4.1.4/.cvsignore
        A       Jetty-4.1.4/build.xml
        A       Jetty-4.1.4/ext/com.sun.net.ssl.jar
        A       Jetty-4.1.4/webapps/root/WEB-INF/web.xml
        A       Jetty-4.1.4/webapps/root/index.html
        A       Jetty-4.1.4/webapps/root/.cvsignore
        A       Jetty-4.1.4/VERSION.TXT
        A       Jetty-4.1.4/LICENSE.html
        A       Jetty-4.1.4/lib/org.mortbay.jetty-jdk1.2.jar
        A       Jetty-4.1.4/lib/org.mortbay.jmx.jar
        A       Jetty-4.1.4/lib/.cvsignore
        A       samples/LocalGet.java
        A       samples/biblio.rdf
        A       samples/catalog
        A       samples/shakespeare/.test.xml.swp
        A       samples/shakespeare/hamlet.xml
        A       samples/shakespeare/r_and_j.xml
        A       samples/shakespeare/test.xml
        A       samples/shakespeare/play.dtd
        A       samples/shakespeare/macbeth.xml
        A       samples/shakespeare/shakes.xsl
        A       samples/xinclude/sidebar.xml
        A       samples/xinclude/xinclude.xml
        A       samples/xinclude/disclaimer.xml
        A       samples/play.dtd
        A       samples/xcatalog.xml
        A       samples/soap/getdoc.pl
        A       samples/soap/query.pl
        A       samples/soap/QueryExample.java
        A       samples/soap/Client.cs
        A       samples/soap/store.pl
        A       samples/soap/remove.pl
        A       samples/soap/QueryService.cs
        A       samples/soap/SoapQuery.cs
        A       samples/soap/AdminService.cs
        A       samples/soap/QueryForm.cs
        A       samples/xmlrpc/Search.java
        A       samples/xmlrpc/Store.java
        A       samples/xmlrpc/Get.java
        A       samples/xmldb/NestedQuery.java
        A       samples/xmldb/APIGet.java
        A       samples/xmldb/APISearch.java
        A       samples/xmldb/APIParse.java
        A       samples/xmldb/APIParseDOM.java
        A       build.bat
        A       lib/optional/logkit-20020529.jar
        A       lib/optional/clutil.jar
        A       lib/optional/commons-JXPath-20020320.jar
        A       lib/optional/commons-logging.jar
        A       lib/optional/jakarta-regexp-1.2.jar
        A       lib/optional/axis.jar
        A       lib/optional/ant-optional.jar
        A       lib/optional/wsdl4j.jar
        A       lib/optional/bsf-2.2.jar
        A       lib/optional/jstyle.jar
        A       lib/optional/maybeupload_1-0-5pre3.jar
        A       lib/optional/avalon-framework-20020627.jar
        A       lib/optional/avalon-excalibur-vm12-20020705.jar
        A       lib/optional/cocoon-2.0.3.jar
        A       lib/optional/saaj.jar
        A       lib/optional/commons-discovery.jar
        A       lib/optional/commons-httpclient-20020423.jar
        A       lib/optional/tt-bytecode.jar
        A       lib/optional/commons-collections-1.0.jar
        A       lib/optional/axis-ant.jar
        A       lib/optional/jaxrpc.jar
        A       lib/core/mysql.jar
        A       lib/core/xmldb.jar
        A       lib/core/jakarta-oro-2.0.6.jar
        A       lib/core/xercesImpl.jar
        A       lib/core/excalibur-cli-1.0.jar
        A       lib/core/log4j.jar
        A       lib/core/antlr.jar
        A       lib/core/ant.jar
        A       lib/core/resolver-20020130.jar
        A       lib/core/junit.jar
        A       lib/core/libreadline-java.jar
        A       lib/core/xml-apis.jar
        A       lib/core/javax.servlet.jar
        A       lib/core/trove.jar
        A       lib/core/xalan-2.3.1.jar
        A       lib/core/xmlrpc-1.1.jar
        A       exist.jar
        A       bin/startup.sh
        A       bin/server.bat
        A       bin/antRun.bat
        A       bin/rpclite.pl
        A       bin/run.sh
        A       bin/server.sh
        A       bin/xmlrpc.pl
        A       bin/shutdown.bat
        A       bin/ant
        A       bin/client.bat
        A       bin/shutdown.sh
        A       bin/ant.bat
        A       bin/client.sh
        A       bin/query.py
        A       bin/cpappend.bat
        A       bin/exist.bat
        A       bin/startup.bat
        A       bin/antRun
        A       bin/run.bat
        A       build.sh
        A       client.properties
        A       default.css
        A       org.mortbay.jetty.jar
fatal: Not a valid object name
ls-tree -z  ./webapp/api/: command returned error: 128

--
Adam Retter

eXist Developer
{ United Kingdom }
adam@exist-db.org
irc://irc.freenode.net/existdb
