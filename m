From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/4] Add a JUnit test project for egit.
Date: Sun, 22 Apr 2007 23:36:16 +0200
Message-ID: <20070422213615.26396.98374.stgit@lathund.dewire.com>
References: <20070422212907.26396.12810.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 22 23:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfjk0-0008R3-DV
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbXDVVg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbXDVVg7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:36:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14907 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbXDVVg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:36:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 08DA5802884;
	Sun, 22 Apr 2007 23:31:03 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25806-01; Sun, 22 Apr 2007 23:31:01 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id AE701802892;
	Sun, 22 Apr 2007 23:31:00 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 0008E29100;
	Sun, 22 Apr 2007 23:36:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ObIQje6ipTmF; Sun, 22 Apr 2007 23:36:38 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 1AEA729806;
	Sun, 22 Apr 2007 23:36:16 +0200 (CEST)
In-Reply-To: <20070422212907.26396.12810.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45281>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 org.spearce.egit.core.test/.classpath              |    7 
 org.spearce.egit.core.test/.project                |   28 ++
 .../.settings/org.eclipse.jdt.core.prefs           |  320 +++++++++++++++++++++++
 .../.settings/org.eclipse.jdt.ui.prefs             |   10 +
 org.spearce.egit.core.test/META-INF/MANIFEST.MF    |   19 +
 org.spearce.egit.core.test/build.properties        |    4 
 .../org.spearce.egit.core--All-Tests.launch        |   39 +++
 .../egit/core/internal/mapping/T0002_history.java  |  108 ++++++++
 .../op/T0001_ConnectProviderOperationTest.java     |  118 ++++++++
 .../src/org/spearce/egit/core/test/Activator.java  |   50 ++++
 .../org/spearce/egit/core/test/GitTestCase.java    |   46 +++
 .../org/spearce/egit/core/test/TestProject.java    |  169 ++++++++++++
 12 files changed, 918 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core.test/.classpath b/org.spearce.egit.core.test/.classpath
new file mode 100644
index 0000000..751c8f2
--- /dev/null
+++ b/org.spearce.egit.core.test/.classpath
@@ -0,0 +1,7 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<classpath>
+	<classpathentry kind="src" path="src"/>
+	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
+	<classpathentry kind="con" path="org.eclipse.pde.core.requiredPlugins"/>
+	<classpathentry kind="output" path="bin"/>
+</classpath>
diff --git a/org.spearce.egit.core.test/.project b/org.spearce.egit.core.test/.project
new file mode 100644
index 0000000..3b7fb2f
--- /dev/null
+++ b/org.spearce.egit.core.test/.project
@@ -0,0 +1,28 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<projectDescription>
+	<name>org.spearce.egit.core.test</name>
+	<comment></comment>
+	<projects>
+	</projects>
+	<buildSpec>
+		<buildCommand>
+			<name>org.eclipse.jdt.core.javabuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+		<buildCommand>
+			<name>org.eclipse.pde.ManifestBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+		<buildCommand>
+			<name>org.eclipse.pde.SchemaBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+	</buildSpec>
+	<natures>
+		<nature>org.eclipse.pde.PluginNature</nature>
+		<nature>org.eclipse.jdt.core.javanature</nature>
+	</natures>
+</projectDescription>
diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
new file mode 100644
index 0000000..16fbddc
--- /dev/null
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
@@ -0,0 +1,320 @@
+#Mon Jan 29 20:50:25 EST 2007
+eclipse.preferences.version=1
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=disabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.4
+org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
+org.eclipse.jdt.core.compiler.compliance=1.4
+org.eclipse.jdt.core.compiler.debug.lineNumber=generate
+org.eclipse.jdt.core.compiler.debug.localVariable=generate
+org.eclipse.jdt.core.compiler.debug.sourceFile=generate
+org.eclipse.jdt.core.compiler.doc.comment.support=enabled
+org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
+org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
+org.eclipse.jdt.core.compiler.problem.autoboxing=ignore
+org.eclipse.jdt.core.compiler.problem.deprecation=warning
+org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
+org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
+org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
+org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
+org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
+org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
+org.eclipse.jdt.core.compiler.problem.fieldHiding=warning
+org.eclipse.jdt.core.compiler.problem.finalParameterBound=warning
+org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
+org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
+org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
+org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=ignore
+org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
+org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsDeprecatedRef=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsNotVisibleRef=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
+org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
+org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
+org.eclipse.jdt.core.compiler.problem.missingJavadocComments=warning
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
+org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
+org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
+org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
+org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
+org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
+org.eclipse.jdt.core.compiler.problem.nullReference=warning
+org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
+org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
+org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
+org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
+org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=warning
+org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
+org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
+org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
+org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
+org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
+org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.unusedImport=error
+org.eclipse.jdt.core.compiler.problem.unusedLabel=error
+org.eclipse.jdt.core.compiler.problem.unusedLocal=error
+org.eclipse.jdt.core.compiler.problem.unusedParameter=warning
+org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=disabled
+org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
+org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
+org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
+org.eclipse.jdt.core.compiler.source=1.4
+org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_explicit_constructor_call=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_qualified_allocation_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_assignment=0
+org.eclipse.jdt.core.formatter.alignment_for_binary_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_compact_if=16
+org.eclipse.jdt.core.formatter.alignment_for_conditional_expression=80
+org.eclipse.jdt.core.formatter.alignment_for_enum_constants=0
+org.eclipse.jdt.core.formatter.alignment_for_expressions_in_array_initializer=16
+org.eclipse.jdt.core.formatter.alignment_for_multiple_fields=16
+org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation=16
+org.eclipse.jdt.core.formatter.alignment_for_superclass_in_type_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_type_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_constructor_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_method_declaration=16
+org.eclipse.jdt.core.formatter.blank_lines_after_imports=1
+org.eclipse.jdt.core.formatter.blank_lines_after_package=1
+org.eclipse.jdt.core.formatter.blank_lines_before_field=1
+org.eclipse.jdt.core.formatter.blank_lines_before_first_class_body_declaration=0
+org.eclipse.jdt.core.formatter.blank_lines_before_imports=1
+org.eclipse.jdt.core.formatter.blank_lines_before_member_type=1
+org.eclipse.jdt.core.formatter.blank_lines_before_method=1
+org.eclipse.jdt.core.formatter.blank_lines_before_new_chunk=1
+org.eclipse.jdt.core.formatter.blank_lines_before_package=0
+org.eclipse.jdt.core.formatter.blank_lines_between_type_declarations=1
+org.eclipse.jdt.core.formatter.brace_position_for_annotation_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_anonymous_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_array_initializer=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_block=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_block_in_case=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_enum_constant=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_enum_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_method_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_switch=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.comment.clear_blank_lines=false
+org.eclipse.jdt.core.formatter.comment.format_comments=true
+org.eclipse.jdt.core.formatter.comment.format_header=false
+org.eclipse.jdt.core.formatter.comment.format_html=true
+org.eclipse.jdt.core.formatter.comment.format_source_code=true
+org.eclipse.jdt.core.formatter.comment.indent_parameter_description=true
+org.eclipse.jdt.core.formatter.comment.indent_root_tags=true
+org.eclipse.jdt.core.formatter.comment.insert_new_line_before_root_tags=insert
+org.eclipse.jdt.core.formatter.comment.insert_new_line_for_parameter=insert
+org.eclipse.jdt.core.formatter.comment.line_length=80
+org.eclipse.jdt.core.formatter.compact_else_if=true
+org.eclipse.jdt.core.formatter.continuation_indentation=2
+org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer=2
+org.eclipse.jdt.core.formatter.format_guardian_clause_on_one_line=false
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_annotation_declaration_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_constant_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_declaration_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header=true
+org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases=true
+org.eclipse.jdt.core.formatter.indent_empty_lines=false
+org.eclipse.jdt.core.formatter.indent_statements_compare_to_block=true
+org.eclipse.jdt.core.formatter.indent_statements_compare_to_body=true
+org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases=true
+org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch=false
+org.eclipse.jdt.core.formatter.indentation.size=4
+org.eclipse.jdt.core.formatter.insert_new_line_after_annotation=insert
+org.eclipse.jdt.core.formatter.insert_new_line_after_opening_brace_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_catch_in_try_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_closing_brace_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_else_in_if_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_finally_in_try_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_while_in_do_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_annotation_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_anonymous_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_block=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_constant=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_method_body=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_after_and_in_type_parameter=insert
+org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation_type_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_binary_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_brace_in_block=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_paren_in_cast=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_assert=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_case=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_labeled_statement=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_allocation_expression=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_annotation=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_throws=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_constant_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_explicitconstructorcall_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_increments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_inits=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_throws=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_field_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_local_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_parameterized_type_reference=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_superinterfaces=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_ellipsis=insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_cast=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_catch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_if=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_switch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_synchronized=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_while=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_postfix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_prefix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_question_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_after_question_in_wildcard=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_after_unary_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_and_in_type_parameter=insert
+org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_before_at_in_annotation_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_binary_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_cast=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_catch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_if=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_switch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_synchronized=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_while=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_assert=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_case=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_default=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_labeled_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_throws=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_constant_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_explicitconstructorcall_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_increments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_inits=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_throws=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_invocation_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_field_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_local_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_superinterfaces=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_ellipsis=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_annotation_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_anonymous_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_constructor_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_constant=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_switch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation_type_member_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_catch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_switch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_synchronized=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while=insert
+org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_return=insert
+org.eclipse.jdt.core.formatter.insert_space_before_postfix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_prefix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_question_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_before_question_in_wildcard=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_semicolon=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_unary_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_brackets_in_array_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_braces_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_brackets_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_annotation_type_member_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line=false
+org.eclipse.jdt.core.formatter.keep_empty_array_initializer_on_one_line=false
+org.eclipse.jdt.core.formatter.keep_imple_if_on_one_line=false
+org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line=false
+org.eclipse.jdt.core.formatter.lineSplit=80
+org.eclipse.jdt.core.formatter.number_of_blank_lines_at_beginning_of_method_body=0
+org.eclipse.jdt.core.formatter.number_of_empty_lines_to_preserve=1
+org.eclipse.jdt.core.formatter.put_empty_statement_on_new_line=true
+org.eclipse.jdt.core.formatter.tabulation.char=tab
+org.eclipse.jdt.core.formatter.tabulation.size=4
+org.eclipse.jdt.core.formatter.use_tabs_only_for_leading_indentations=false
diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs
new file mode 100644
index 0000000..273e64b
--- /dev/null
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs
@@ -0,0 +1,10 @@
+#Mon Jan 29 20:38:19 EST 2007
+eclipse.preferences.version=1
+formatter_profile=_EGit
+formatter_settings_version=10
+internal.default.compliance=user
+org.eclipse.jdt.ui.ignorelowercasenames=true
+org.eclipse.jdt.ui.importorder=java;javax;org;com;
+org.eclipse.jdt.ui.ondemandthreshold=99
+org.eclipse.jdt.ui.staticondemandthreshold=99
+org.eclipse.jdt.ui.text.custom_code_templates=<?xml version\="1.0" encoding\="UTF-8"?><templates/>
diff --git a/org.spearce.egit.core.test/META-INF/MANIFEST.MF b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
new file mode 100644
index 0000000..e201e46
--- /dev/null
+++ b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
@@ -0,0 +1,19 @@
+Manifest-Version: 1.0
+Bundle-ManifestVersion: 2
+Bundle-Name: Test Plug-in
+Bundle-SymbolicName: org.spearce.egit.core.test
+Bundle-Version: 0.2.0
+Bundle-Activator: org.spearce.egit.core.test.Activator
+Require-Bundle: org.eclipse.core.runtime,
+ org.eclipse.team.core,
+ org.junit,
+ org.spearce.egit.core,
+ org.spearce.egit.ui,
+ org.spearce.jgit,
+ org.eclipse.core.filesystem
+Eclipse-LazyStart: true
+Import-Package: org.eclipse.core.resources,
+ org.eclipse.jdt.core,
+ org.eclipse.jdt.junit,
+ org.eclipse.jdt.launching
+Export-Package: org.spearce.egit.core.internal.mapping
diff --git a/org.spearce.egit.core.test/build.properties b/org.spearce.egit.core.test/build.properties
new file mode 100644
index 0000000..34d2e4d
--- /dev/null
+++ b/org.spearce.egit.core.test/build.properties
@@ -0,0 +1,4 @@
+source.. = src/
+output.. = bin/
+bin.includes = META-INF/,\
+               .
diff --git a/org.spearce.egit.core.test/org.spearce.egit.core--All-Tests.launch b/org.spearce.egit.core.test/org.spearce.egit.core--All-Tests.launch
new file mode 100644
index 0000000..f4c9d3c
--- /dev/null
+++ b/org.spearce.egit.core.test/org.spearce.egit.core--All-Tests.launch
@@ -0,0 +1,39 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<launchConfiguration type="org.eclipse.pde.ui.JunitLaunchConfig">
+<stringAttribute key="product" value="org.eclipse.sdk.ide"/>
+<stringAttribute key="bootstrap" value=""/>
+<booleanAttribute key="useProduct" value="true"/>
+<booleanAttribute key="tracing" value="false"/>
+<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_TYPES">
+<listEntry value="4"/>
+</listAttribute>
+<listAttribute key="org.eclipse.debug.ui.favoriteGroups">
+<listEntry value="org.eclipse.debug.ui.launchGroup.run"/>
+<listEntry value="org.eclipse.debug.ui.launchGroup.debug"/>
+</listAttribute>
+<stringAttribute key="org.eclipse.jdt.junit.CONTAINER" value="=org.spearce.egit.core.test"/>
+<booleanAttribute key="automaticValidate" value="false"/>
+<booleanAttribute key="org.eclipse.jdt.junit.KEEPRUNNING_ATTR" value="false"/>
+<booleanAttribute key="automaticAdd" value="true"/>
+<stringAttribute key="checked" value="[NONE]"/>
+<stringAttribute key="location" value="${workspace_loc}/../junit-workspace"/>
+<stringAttribute key="configLocation" value="${workspace_loc}/.metadata/.plugins/org.eclipse.pde.core/pde-junit"/>
+<booleanAttribute key="clearws" value="true"/>
+<stringAttribute key="org.eclipse.jdt.launching.MAIN_TYPE" value=""/>
+<stringAttribute key="pde.version" value="3.3"/>
+<stringAttribute key="org.eclipse.jdt.launching.VM_ARGUMENTS" value="-ea"/>
+<booleanAttribute key="default" value="true"/>
+<booleanAttribute key="clearConfig" value="true"/>
+<booleanAttribute key="org.eclipse.debug.core.appendEnvironmentVariables" value="true"/>
+<stringAttribute key="org.eclipse.jdt.launching.SOURCE_PATH_PROVIDER" value="org.eclipse.pde.ui.workbenchClasspathProvider"/>
+<booleanAttribute key="useDefaultConfigArea" value="false"/>
+<booleanAttribute key="useDefaultConfig" value="true"/>
+<stringAttribute key="org.eclipse.jdt.junit.TESTNAME" value=""/>
+<stringAttribute key="org.eclipse.jdt.launching.PROJECT_ATTR" value="org.spearce.egit.core.test"/>
+<booleanAttribute key="askclear" value="false"/>
+<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_PATHS">
+<listEntry value="/org.spearce.egit.core.test"/>
+</listAttribute>
+<booleanAttribute key="includeOptional" value="true"/>
+<stringAttribute key="org.eclipse.jdt.junit.TEST_KIND" value="org.eclipse.jdt.junit.loader.junit3"/>
+</launchConfiguration>
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
new file mode 100644
index 0000000..aaf9dce
--- /dev/null
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
@@ -0,0 +1,108 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.core.internal.mapping;
+
+import java.io.File;
+import java.io.FileWriter;
+import java.io.IOException;
+import java.util.Date;
+
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.team.core.RepositoryProvider;
+import org.eclipse.team.core.history.IFileHistory;
+import org.eclipse.team.core.history.IFileHistoryProvider;
+import org.eclipse.team.core.history.IFileRevision;
+import org.spearce.egit.core.GitProvider;
+import org.spearce.egit.core.op.ConnectProviderOperation;
+import org.spearce.egit.core.test.GitTestCase;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.FileTreeEntry;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tree;
+
+public class T0002_history extends GitTestCase {
+
+	protected static final PersonIdent jauthor;
+
+	protected static final PersonIdent jcommitter;
+
+	static {
+		jauthor = new PersonIdent("J. Author", "jauthor@example.com");
+		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
+	}
+
+	private File workDir;
+	private File gitDir;
+	private Repository thisGit;
+	private Tree tree;
+	private ObjectWriter objectWriter;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		project.createSourceFolder();
+		gitDir = new File(project.getProject().getWorkspace().getRoot()
+				.getRawLocation().toFile(), ".git");
+		workDir = gitDir.getParentFile();
+		thisGit = new Repository(gitDir);
+		thisGit.create();
+		objectWriter = new ObjectWriter(thisGit);
+
+		tree = new Tree(thisGit);
+		Tree projectTree = tree.addTree("Project-1");
+		File project1_a_txt = createFile("Project-1/A.txt","A.txt - first version\n");
+		addFile(projectTree,project1_a_txt);
+		projectTree.setId(objectWriter.writeTree(projectTree));
+		tree.setId(objectWriter.writeTree(tree));
+		Commit commit = new Commit(thisGit);
+		commit.setAuthor(new PersonIdent(jauthor, new Date(0L)));
+		commit.setCommitter(new PersonIdent(jcommitter, new Date(0L)));
+		commit.setMessage("Foo\n\nMessage");
+		commit.setTree(tree);
+		ObjectId commitId = objectWriter.writeCommit(commit);
+		thisGit.writeRef("refs/heads/master", commitId);
+
+		ConnectProviderOperation operation = new ConnectProviderOperation(
+				project.getProject(), null);
+		operation.run(null);
+	}
+	
+	private void addFile(Tree t,File f) throws IOException {
+		ObjectId id = objectWriter.writeBlob(f);
+		t.addEntry(new FileTreeEntry(t,id,f.getName().getBytes("UTF-8"),false));
+	}
+
+	private File createFile(String name, String content) throws IOException {
+		File f = new File(workDir, name);
+		FileWriter fileWriter = new FileWriter(f);
+		fileWriter.write(content);
+		fileWriter.close();
+		return f;
+	}
+
+	public void testShallowHistory() {
+		GitProvider provider = (GitProvider)RepositoryProvider.getProvider(project.project);
+		assertNotNull(provider);
+		IFileHistoryProvider fileHistoryProvider = provider.getFileHistoryProvider();
+		IFileHistory fileHistory = fileHistoryProvider.getFileHistoryFor(project.getProject().getWorkspace().getRoot().findMember("Project-1/A.txt"), IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, new NullProgressMonitor());
+		IFileRevision[] fileRevisions = fileHistory.getFileRevisions();
+		assertEquals(1, fileRevisions.length);
+		assertEquals("e2eadee5e6de7315df91cf03a75a8b2194a69af2", fileRevisions[0].getContentIdentifier());
+	}
+}
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
new file mode 100644
index 0000000..63ba83e
--- /dev/null
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
@@ -0,0 +1,118 @@
+package org.spearce.egit.core.op;
+
+import java.io.ByteArrayInputStream;
+import java.io.File;
+import java.io.IOException;
+import java.util.Date;
+import java.util.TimeZone;
+
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.jobs.Job;
+import org.eclipse.team.core.RepositoryProvider;
+import org.spearce.egit.core.test.GitTestCase;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.FileTreeEntry;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tree;
+
+public class T0001_ConnectProviderOperationTest extends GitTestCase {
+
+	public void testNoRepository() throws CoreException {
+
+		ConnectProviderOperation operation = new ConnectProviderOperation(
+				project.getProject(), null);
+		operation.run(null);
+
+		// We are shared because we declared as shared
+		assertTrue(RepositoryProvider.isShared(project.getProject()));
+		assertTrue(!gitDir.exists());
+	}
+
+	public void testNewRepository() throws CoreException {
+
+		File gitDir = new File(project.getProject().getWorkspace().getRoot()
+				.getRawLocation().toFile(), ".git");
+		ConnectProviderOperation operation = new ConnectProviderOperation(
+				project.getProject(), gitDir);
+		operation.run(null);
+
+		assertTrue(RepositoryProvider.isShared(project.getProject()));
+
+		assertTrue(gitDir.exists());
+	}
+
+	public void testNewUnsharedFile() throws CoreException, IOException,
+			InterruptedException {
+
+		project.createSourceFolder();
+		IFile fileA = project.getProject().getFolder("src").getFile("A.java");
+		String srcA = "class A {\n" + "}\n";
+		fileA.create(new ByteArrayInputStream(srcA.getBytes()), false, null);
+
+		File gitDir = new File(project.getProject().getWorkspace().getRoot()
+				.getRawLocation().toFile(), ".git");
+		Repository thisGit = new Repository(gitDir);
+		thisGit.create();
+		Tree rootTree = new Tree(thisGit);
+		Tree prjTree = rootTree.addTree(project.getProject().getName());
+		Tree srcTree = prjTree.addTree("src");
+		FileTreeEntry entryA = srcTree.addFile("A.java");
+		ObjectWriter writer = new ObjectWriter(thisGit);
+		entryA.setId(writer.writeBlob(fileA.getRawLocation().toFile()));
+		srcTree.setId(writer.writeTree(srcTree));
+		prjTree.setId(writer.writeTree(prjTree));
+		rootTree.setId(writer.writeTree(rootTree));
+		Commit commit = new Commit(thisGit);
+		commit.setTree(rootTree);
+		commit.setAuthor(new PersonIdent("J. Git", "j.git@egit.org", new Date(
+				1999, 1, 1), TimeZone.getTimeZone("GMT+1")));
+		commit.setCommitter(commit.getAuthor());
+		commit.setMessage("testNewUnsharedFile\n\nJunit tests\n");
+		ObjectId id = writer.writeCommit(commit);
+		thisGit.writeRef("refs/heads/master", id);
+
+		// helper asserts, this is not what we are really testing
+		assertTrue("blob missing", new File(gitDir,
+				"objects/2e/2439c32d01f0ef39644d561945e8f4b2239489").exists());
+
+		assertTrue("tree missing", new File(gitDir,
+				"objects/87/a105cc4bc0a79885d07ec560c3eee49438acf0").exists());
+		assertTrue("tree missing", new File(gitDir,
+				"objects/08/ccc3d91a14d337a45f355d3d63bd97fd5e4db9").exists());
+		assertTrue("tree missing", new File(gitDir,
+				"objects/9d/aeec817090098f05eeca858e3a552d78b0a346").exists());
+
+		assertTrue("commit missing", new File(gitDir,
+				"objects/45/df73fd9abbc2c61620c036948b1157e4d21253").exists());
+
+		ConnectProviderOperation operation = new ConnectProviderOperation(
+				project.getProject(), null);
+		operation.run(null);
+
+		final boolean f[] = new boolean[1];
+		new Job("wait") {
+			protected IStatus run(IProgressMonitor monitor) {
+
+				System.out.println("MyJob");
+				f[0] = true;
+				return null;
+			}
+
+			{
+				setRule(project.getProject());
+				schedule();
+			}
+		};
+		while (!f[0]) {
+			System.out.println("Waiting");
+			Thread.sleep(1000);
+		}
+		System.out.println("DONE");
+	}
+}
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java
new file mode 100644
index 0000000..9807c84
--- /dev/null
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/Activator.java
@@ -0,0 +1,50 @@
+package org.spearce.egit.core.test;
+
+import org.eclipse.core.runtime.Plugin;
+import org.osgi.framework.BundleContext;
+
+/**
+ * The activator class controls the plug-in life cycle
+ */
+public class Activator extends Plugin {
+
+	// The plug-in ID
+	public static final String PLUGIN_ID = "org.spearce.egit.core.test";
+
+	// The shared instance
+	private static Activator plugin;
+
+	/**
+	 * The constructor
+	 */
+	public Activator() {
+	}
+
+	/*
+	 * (non-Javadoc)
+	 * @see org.eclipse.core.runtime.Plugins#start(org.osgi.framework.BundleContext)
+	 */
+	public void start(BundleContext context) throws Exception {
+		super.start(context);
+		plugin = this;
+	}
+
+	/*
+	 * (non-Javadoc)
+	 * @see org.eclipse.core.runtime.Plugin#stop(org.osgi.framework.BundleContext)
+	 */
+	public void stop(BundleContext context) throws Exception {
+		plugin = null;
+		super.stop(context);
+	}
+
+	/**
+	 * Returns the shared instance
+	 *
+	 * @return the shared instance
+	 */
+	public static Activator getDefault() {
+		return plugin;
+	}
+
+}
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/test/GitTestCase.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/GitTestCase.java
new file mode 100644
index 0000000..4e4fbf0
--- /dev/null
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/GitTestCase.java
@@ -0,0 +1,46 @@
+package org.spearce.egit.core.test;
+
+import java.io.File;
+import java.io.IOException;
+
+import junit.framework.TestCase;
+
+public abstract class GitTestCase extends TestCase {
+
+	protected TestProject project;
+
+	protected File gitDir;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		project = new TestProject();
+		gitDir = new File(project.getProject().getWorkspace().getRoot()
+				.getRawLocation().toFile(), ".git");
+		rmrf(gitDir);
+	}
+
+	protected void tearDown() throws Exception {
+		super.tearDown();
+		project.dispose();
+		rmrf(gitDir);
+	}
+
+	private void rmrf(File d) throws IOException {
+		if (!d.exists())
+			return;
+
+		File[] files = d.listFiles();
+		if (files != null) {
+			for (int i = 0; i < files.length; ++i) {
+				if (files[i].isDirectory())
+					rmrf(files[i]);
+				else if (!files[i].delete())
+					throw new IOException(files[i] + " in use or undeletable");
+			}
+		}
+		if (!d.delete())
+			throw new IOException(d + " in use or undeletable");
+		assert !d.exists();
+	}
+
+}
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/test/TestProject.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/TestProject.java
new file mode 100644
index 0000000..63c0d4b
--- /dev/null
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/test/TestProject.java
@@ -0,0 +1,169 @@
+package org.spearce.egit.core.test;
+
+import java.io.IOException;
+import java.net.MalformedURLException;
+import java.net.URL;
+
+import org.eclipse.core.resources.IFolder;
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IProjectDescription;
+import org.eclipse.core.resources.IWorkspaceRoot;
+import org.eclipse.core.resources.ResourcesPlugin;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.core.runtime.IPluginDescriptor;
+import org.eclipse.core.runtime.IPluginRegistry;
+import org.eclipse.core.runtime.Path;
+import org.eclipse.core.runtime.Platform;
+import org.eclipse.jdt.core.IClasspathEntry;
+import org.eclipse.jdt.core.ICompilationUnit;
+import org.eclipse.jdt.core.IJavaProject;
+import org.eclipse.jdt.core.IPackageFragment;
+import org.eclipse.jdt.core.IPackageFragmentRoot;
+import org.eclipse.jdt.core.IType;
+import org.eclipse.jdt.core.JavaCore;
+import org.eclipse.jdt.core.JavaModelException;
+import org.eclipse.jdt.launching.JavaRuntime;
+
+public class TestProject {
+	public IProject project;
+
+	public IJavaProject javaProject;
+
+	private IPackageFragmentRoot sourceFolder;
+
+	public TestProject() throws CoreException {
+		IWorkspaceRoot root = ResourcesPlugin.getWorkspace().getRoot();
+		project = root.getProject("Project-1");
+		project.create(null);
+		project.open(null);
+		javaProject = JavaCore.create(project);
+		IFolder binFolder = createBinFolder();
+		setJavaNature();
+		javaProject.setRawClasspath(new IClasspathEntry[0], null);
+		createOutputFolder(binFolder);
+		addSystemLibraries();
+	}
+
+	public IProject getProject() {
+		return project;
+	}
+
+	public IJavaProject getJavaProject() {
+		return javaProject;
+	}
+
+	public void addJar(String plugin, String jar) throws MalformedURLException,
+			IOException, JavaModelException {
+		Path result = findFileInPlugin(plugin, jar);
+		IClasspathEntry[] oldEntries = javaProject.getRawClasspath();
+		IClasspathEntry[] newEntries = new IClasspathEntry[oldEntries.length + 1];
+		System.arraycopy(oldEntries, 0, newEntries, 0, oldEntries.length);
+		newEntries[oldEntries.length] = JavaCore.newLibraryEntry(result, null,
+				null);
+		javaProject.setRawClasspath(newEntries, null);
+	}
+
+	public IPackageFragment createPackage(String name) throws CoreException {
+		if (sourceFolder == null)
+			sourceFolder = createSourceFolder();
+		return sourceFolder.createPackageFragment(name, false, null);
+	}
+
+	public IType createType(IPackageFragment pack, String cuName, String source)
+			throws JavaModelException {
+		StringBuffer buf = new StringBuffer();
+		buf.append("package " + pack.getElementName() + ";\n");
+		buf.append("\n");
+		buf.append(source);
+		ICompilationUnit cu = pack.createCompilationUnit(cuName,
+				buf.toString(), false, null);
+		return cu.getTypes()[0];
+	}
+
+	public void dispose() throws CoreException {
+		waitForIndexer();
+		project.delete(true, true, null);
+	}
+
+	private IFolder createBinFolder() throws CoreException {
+		IFolder binFolder = project.getFolder("bin");
+		binFolder.create(false, true, null);
+		return binFolder;
+	}
+
+	private void setJavaNature() throws CoreException {
+		IProjectDescription description = project.getDescription();
+		description.setNatureIds(new String[] { JavaCore.NATURE_ID });
+		project.setDescription(description, null);
+	}
+
+	private void createOutputFolder(IFolder binFolder)
+			throws JavaModelException {
+		IPath outputLocation = binFolder.getFullPath();
+		javaProject.setOutputLocation(outputLocation, null);
+	}
+
+	public IPackageFragmentRoot createSourceFolder() throws CoreException {
+		IFolder folder = project.getFolder("src");
+		folder.create(false, true, null);
+		IPackageFragmentRoot root = javaProject.getPackageFragmentRoot(folder);
+		IClasspathEntry[] oldEntries = javaProject.getRawClasspath();
+		IClasspathEntry[] newEntries = new IClasspathEntry[oldEntries.length + 1];
+		System.arraycopy(oldEntries, 0, newEntries, 0, oldEntries.length);
+		newEntries[oldEntries.length] = JavaCore.newSourceEntry(root.getPath());
+		javaProject.setRawClasspath(newEntries, null);
+		return root;
+	}
+
+	private void addSystemLibraries() throws JavaModelException {
+		IClasspathEntry[] oldEntries = javaProject.getRawClasspath();
+		IClasspathEntry[] newEntries = new IClasspathEntry[oldEntries.length + 1];
+		System.arraycopy(oldEntries, 0, newEntries, 0, oldEntries.length);
+		newEntries[oldEntries.length] = JavaRuntime
+				.getDefaultJREContainerEntry();
+		javaProject.setRawClasspath(newEntries, null);
+	}
+
+	private Path findFileInPlugin(String plugin, String file)
+			throws MalformedURLException, IOException {
+		IPluginRegistry registry = Platform.getPluginRegistry();
+		IPluginDescriptor descriptor = registry.getPluginDescriptor(plugin);
+		URL pluginURL = descriptor.getInstallURL();
+		URL jarURL = new URL(pluginURL, file);
+		URL localJarURL = Platform.asLocalURL(jarURL);
+		return new Path(localJarURL.getPath());
+	}
+
+	public void waitForIndexer() {
+		//                new SearchEngine().searchAllTypeNames(ResourcesPlugin.getWorkspace(),
+		//                                null, null, IJavaSearchConstants.EXACT_MATCH,
+		//                                IJavaSearchConstants.CASE_SENSITIVE,
+		//                                IJavaSearchConstants.CLASS, SearchEngine
+		//                                                .createJavaSearchScope(new IJavaElement[0]),
+		//                                new ITypeNameRequestor() {
+		//                                        public void acceptClass(char[] packageName,
+		//                                                        char[] simpleTypeName, char[][] enclosingTypeNames,
+		//                                                        String path) {
+		//                                        }
+		//                                        public void acceptInterface(char[] packageName,
+		//                                                        char[] simpleTypeName, char[][] enclosingTypeNames,
+		//                                                        String path) {
+		//                                        }
+		//                                }, IJavaSearchConstants.WAIT_UNTIL_READY_TO_SEARCH, null);
+	}
+
+	/**
+	 * @return Returns the sourceFolder.
+	 */
+	public IPackageFragmentRoot getSourceFolder() {
+		return sourceFolder;
+	}
+
+	/**
+	 * @param sourceFolder The sourceFolder to set.
+	 */
+	public void setSourceFolder(IPackageFragmentRoot sourceFolder) {
+		this.sourceFolder = sourceFolder;
+	}
+}
